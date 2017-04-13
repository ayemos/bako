
module Bako
  class DSL::Context::JobDefinition
    attr_reader :name, :type_b, :image_b, :command_b, :role_arn_b, :memory_b, :vcpus_b

    def initialize(name, &block)
      @name = name
      @type_b = 'container'

      instance_eval(&block)
    end

    private

    def type(job_type)
      @type_b = job_type
    end

    def image(image_b)
      @image_b = image_b
    end

    def command(command_b)
      @command_b = command_b
    end

    def role_arn(role_arn_b)
      @role_arn_b = role_arn_b
    end

    def memory(memory_b)
      @memory_b = memory_b
    end

    def vcpus(vcpus_b)
      @vcpus_b = vcpus_b
    end
  end
end
