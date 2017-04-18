# frozen_string_literal: true
#
require 'active_support/core_ext/string/inflections'

class Bako::DSL::Context
  attr_reader :result

  def self.eval(dsl)
    new do
      eval(dsl)
    end
  end

  def initialize(&block)

    @result = {
      jobs: {},
      job_definitions: {},
    }

    instance_eval(&block)
  end

  private

  %i[
    job
    job_definition
  ].each do |context|
    define_method(context) do |name, &block|
      name = name.to_s
      result_key = context.to_s.pluralize.to_sym

      if result[result_key][name]
        raise "#{context.to_s.capitalize} `#{name}` is already defined"
      end

      @result[result_key][name] = load_context(context).new(name, &block)
    end
  end

  def load_context(context)
    Object.const_get("Bako::DSL::Context::#{context.to_s.camelize}")
  end
end
