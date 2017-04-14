module Bako
  class DSL::Context::Job
    attr_reader :name, :param_b, :job_definition_b, :depends_on_b, :memory_b, :vcpus_b, :job_queue_b, :command_b

    def initialize(name, &block)
      @name = name

      instance_eval(&block)
    end

    private

    def job_definition(jd)
      if jd.nil?
        raise InvalidArgumentError.new('JobDefinition must be set')
      end

      @job_definition_b =
        if jd.is_a?(Bako::DSL::Context::JobDefinition)
          jd
        elsif jd.is_a?(String)
          remote_job_definition(jd)
        else raise InvalidArgumentError.new('JobDefinition must be String or Bako::DSL::Context::JobDefinition')
        end
    end

    def depends_on(jobs)
      @depends_on_b = jobs&.map do |job|
        if job.is_a?(Bako::DSL::Context::Job)
          job
        elsif job.is_a?(String)
          remote_job(job)
        else
          raise InvalidArgumentError.new('Job must be String or Bako::DSL::Context::Job')
        end
      end
    end

    def param(h)
      @param_b = h
    end

    def memory(memory_b)
      @memory_b = memory_b
    end

    def vcpus(vcpus_b)
      @vcpus_b = vcpus_b
    end

    def job_queue(job_queue_b)
      @job_queue_b = job_queue_b
    end

    def command(command_b)
      if command_b.is_a?(Array)
        @command_b = command_b.map(&:to_s)
      else
        @command_b = command_b.split.map(&:to_s)
      end
    end
  end
end
