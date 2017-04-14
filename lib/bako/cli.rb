# frozen_string_literal: true

require 'thor'

module Bako
  class CLI < Thor
    class_option :verbose, aliases: '-v', type: :boolean
    map '--version' => :print_version

    desc 'run', 'run job'
    def runjob(path)
      require 'bako/cli/run'
      Bako::CLI::Run.new(path, options, self).run
    end
  end
end
