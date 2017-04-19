# frozen_string_literal: true

require 'yaml'
require 'pathname'

module Bako
  module Models
    class JobDefinition
      include Bako::CommonHelper

      attr_reader :name, :command, :role_arn, :image, :type, :arn, :memory, :vcpus

      def self.from_context(context, dry_run: false)
        new(
          context.name,
          context.result,
          dry_run: dry_run
        )
      end

      def initialize(name, result, dry_run: false)
        @name = name
        @command = result[:command]
        @image = result[:image]
        @role_arn = result[:role_arn]
        @type = result[:type]
        @memory = result[:memory]
        @vcpus = result[:vcpus]
        @dry_run = dry_run
      end

      def register
        Bako.logger.info("Registering JobDefinition #{@name}")
        jd_arg = {
          type: @type,
          container_properties: {
            command: @command,
            image: @image,
            memory: @memory || DEFAULTS[:memory],
            vcpus: @vcpus || DEFAULTS[:vcpus],
          },
          job_definition_name: @name
        }

        Bako.logger.info("\n#{jd_arg.to_yaml}\n")

        if @dry_run
          @arn = 'dry_run'
          @revision = 'dry_run'
        else
          resp = batch_client.register_job_definition(jd_arg)

          @arn = resp.job_definition_arn
          @revision = resp.revision
        end

        Bako.logger.info("Registered JobDefinition #{@name}:#{@revision} (arn: #{@arn})")
      end

      def remote_exists?
        !remote_job_definition(@name, 'ACTIVE').nil?
      end
    end
  end
end
