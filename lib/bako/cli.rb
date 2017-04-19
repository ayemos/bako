# frozen_string_literal: true

require 'thor'

module Bako
  class CLI < Thor
    class_option :verbose, aliases: '-v', type: :boolean
    map '--version' => :print_version

    desc 'run JOB_FILE', 'Run batch job'
    method_option :dry_run, aliases: '-n', type: :boolean,
      desc: 'Run job locally without call any actual APIs'
    def runjob(path)
      require 'bako/cli/run'
      Bako::CLI::Run.new(path, options, self).run
    end
  end
end
