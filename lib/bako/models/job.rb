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
          context.job_definition_b,
          context.depends_on_b&.map{|job_context|
            Bako::Models::Job.from_context(job_context)
          },
          context.param_b,
          context.memory_b,
          context.vcpus_b,
          context.job_queue_b,
          context.command_b
        )
      end

      def initialize(name, job_definition, depends_on, param, memory, vcpus, job_queue, command)
        @name = name
        @job_definition = job_definition
        @depends_on = depends_on
        @param = param
        @memory = memory
        @vcpus = vcpus
        @job_queue = job_queue
        @command = command
      end

      def start
        # start 'depends_on' jobs first
        d_ids = []

        @depends_on&.each do |job|
          d_ids << job.start.job_id
        end

        Bako.logger.info("Submitting job #{@name}")
        # start job
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
        Bako.logger.info("Submitted job #{@name} (id: #{@id})")

        resp
      end
    end
  end
end
