# frozen_string_literal: true

require 'yaml'
require 'pathname'

module Bako
  module Models
    class Job
      include Bako::CommonHelper

      attr_reader :name, :job_definition, :depends_on, :param, :id, :memory, :vcpus, :job_queue, :command

      def self.from_context(context, dry_run: false)
        new(
          context.name,
          context.result,
          dry_run: dry_run
        )
      end

      def initialize(name, result, dry_run: false)
        @name = name
        @job_definition = result[:job_definition]
        @depends_on = result[:depends_on]&.map{|job_context|
          Bako::Models::Job.from_context(job_context)
        }
        @param = result[:param]
        @memory = result[:memory]
        @vcpus = result[:vcpus]
        @job_queue = result[:job_queue]
        @command = result[:command]
        @dry_run = dry_run
      end

      def start
        _start(dry_run: @dry_run)
      end

      def _start(dry_run: false)
        # start 'depends_on' jobs first
        @depends_on&.each{|j| j._start(dry_run: dry_run)}

        Bako.logger.info("Submitting job #{@name}:")
        job_arg = {
          job_definition: @job_definition.name,
          job_name: @name,
          job_queue: @job_queue,
          depends_on: @depends_on&.map{|j| [[:job_id, j.id]].to_h},
          parameters: @param,
          container_overrides: {
            command: @command,
            vcpus: @vcpus,
            memory: @memory
          }
        }

        Bako.logger.info("\n#{job_arg.to_yaml}\n")

        # start job
        if dry_run
          @id = '(dry_run)'
        else
          resp = batch_client.submit_job(job_arg)
          @id = resp.job_id
        end

        Bako.logger.info("Submitted job #{@name} (id: #{@id})")

        resp
      end
    end
  end
end
