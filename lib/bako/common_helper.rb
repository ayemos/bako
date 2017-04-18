# frozen_string_literal: true

require 'aws-sdk'

module Bako
  module CommonHelper
    DEFAULTS = {
      vcpus: 1,
      memory: 128
    }

    def batch_client
      @batch_client ||= Aws::Batch::Client.new
    end

    def remote_job_definition(name_or_arn, status=nil)
      remote_job_definitions(status).find{|jd|
        jd.name == name_or_arn || (jd.arn || jd.arn == name_or_arn)
      }
    end

    def remote_job_definitions(status=nil)
      batch_client.describe_job_definitions({
        status: status
      }).job_definitions.map do |jd|
        Bako::Models::JobDefinition.new(
          jd.job_definition_name,
          {
            command: jd.container_properties&.command,
            image: jd.container_properties&.image,
            role_arn: jd.container_properties&.job_role_arn,
            type: jd.type,
            memory: jd.container_properties&.memory,
            vcpus: jd.container_properties&.vcpus,
          }
        )
      end
    end
  end
end
