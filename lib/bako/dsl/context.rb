# frozen_string_literal: true

class Bako::DSL::Context
  attr_reader :jobs, :job_definitions

  def self.eval(dsl)
    new do
      eval(dsl)
    end
  end

  def initialize(&block)
    @jobs = {}
    @job_definitions = {}

    instance_eval(&block)
  end

  private

  def job(name, &block)
    name = name.to_s

    if @jobs[name]
      raise "Job `#{name}` is already defined"
    end

    @jobs[name] = Bako::DSL::Context::Job.new(name, &block)
  end

  def job_definition(name, &block)
    name = name.to_s

    if @job_definitions[name]
      raise "JobDefinition `#{name}` is already defined"
    end

    @job_definitions[name] = Bako::DSL::Context::JobDefinition.new(name, &block)
  end
end
