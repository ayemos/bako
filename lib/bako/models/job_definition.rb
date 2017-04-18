# frozen_string_literal: true

require 'yaml'
require 'pathname'

module Bako
  module Models
    class JobDefinition
      include Bako::CommonHelper

      attr_reader :name, :command, :role_arn, :image, :type, :arn, :memory, :vcpus

      def self.from_context(context)
        new(
          context.name,
          context.result
        )
      end

      def initialize(name, result)
        @name = name
        @command = result[:command]
        @image = result[:image]
        @role_arn = result[:role_arn]
        @type = result[:type]
        @memory = result[:memory]
        @vcpus = result[:vcpus]
      end

      def register
        Bako.logger.info("Registering JobDefinition #{@name}")

        resp = batch_client.register_job_definition({
          type: @type,
          container_properties: {
            command: @command,
            image: @image,
            memory: @memory || DEFAULTS[:memory],
            vcpus: @vcpus || DEFAULTS[:vcpus],
          },
          job_definition_name: @name
        })

        @arn = resp.job_definition_arn
        @revision = resp.revision
        Bako.logger.info("Registered JobDefinition #{@name}:#{@revision} (arn: #{@arn})")
      end

      def remote_exists?
        !remote_job_definition(@name, 'ACTIVE').nil?
      end
    end
  end
end
