# frozen_string_literal: true

class Bako::DSL
  class << self
    def parse(dsl)
      require 'bako/dsl/context'
      Bako::DSL::Context.eval(dsl)
    end
  end # of class methods
end
