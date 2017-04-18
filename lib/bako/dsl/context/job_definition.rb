# frozen_string_literal: true

module Bako
  class DSL::Context::JobDefinition
    attr_reader :name, :result

    def initialize(name, &block)
      @name = name
      @result = {}

      instance_eval(&block)
      validate!
    end

    private

    def validate!
      raise InvalidArgumentError.new('type must be set') unless result[:type]
    end

    %i[
      type
      image
      command
      role_arn
      memory
      vcpus
    ].each do |attr|
      define_method(attr) do |v|
        result[attr] = v
      end
    end
  end
end
