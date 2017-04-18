# frozen_string_literal: true

module Bako
  class DSL::Context::Job
    attr_reader :name, :result

    def initialize(name, &block)
      @name = name
      @result = {}

      instance_eval(&block)
      validate!
    end

    private

    %i[
      param
      memory
      vcpus
      job_queue
    ].each do |attr|
      define_method(attr) do |v|
        result[attr] = v
      end
    end

    def validate!
      raise InvalidArgumentError.new('job_queue must be set') unless result[:job_queue]
      raise InvalidArgumentError.new('job_definition must be set') unless result[:job_definition]
    end

    def job_definition(jd)
      if jd.nil?
        raise InvalidArgumentError.new('JobDefinition must be set')
      end

      result[:job_definition] =
        if jd.is_a?(Bako::DSL::Context::JobDefinition)
          jd
        elsif jd.is_a?(String)
          remote_job_definition(jd)
        else
          raise InvalidArgumentError.new('JobDefinition must be String or Bako::DSL::Context::JobDefinition')
        end
    end

    def depends_on(jobs)
      result[:depends_on] = jobs&.map do |job|
        if job.is_a?(Bako::DSL::Context::Job)
          job
        elsif job.is_a?(String)
          remote_job(job)
        else
          raise InvalidArgumentError.new('Job must be String or Bako::DSL::Context::Job')
        end
      end
    end

    def command(v)
      result[:command] = if v.is_a?(Array)
        v.map(&:to_s)
      else
        v.split.map(&:to_s)
      end
    end
  end
end
