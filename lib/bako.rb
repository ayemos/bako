require "bako/version"
require 'bako/common_helper'

module Bako
  def Bako.logger
    @logger ||= Logger.new(STDOUT)
  end
end

require 'bako/dsl'
require 'bako/dsl/context'
require 'bako/dsl/context/job'
require 'bako/dsl/context/job_definition'

require 'bako/models/job'
require 'bako/models/job_definition'

