# frozen_string_literal: true

require 'yaml'
require 'pathname'

module Bako
  module Models
    class Job
      include Bako::CommonHelper

      attr_reader :name, :job_definition, :depends_on, :param, :id, :memory, :vcpus, :job_queue, :command

      def self.from_context(context)
        new(
          context.name,
          context.result
        )
      end

      def initialize(name, result)
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
      end

      def start
        # start 'depends_on' jobs first
        d_ids = []

        @depends_on&.each do |job|
          d_ids << job.start.job_id
        end

        Bako.logger.info("Submitting job #{@name}:")
        Bako.logger.info({
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
        })

        # start job
=begin
        resp = batch_client.submit_job({
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
        })

        @id = resp.job_id
=end
        Bako.logger.info("Submitted job #{@name} (id: #{@id})")

        resp
      end
    end
  end
end
