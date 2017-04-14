# frozen_string_literal: true

module Bako
  class CLI::Run
    include Bako::CommonHelper

    def initialize(path, options, thor)
      @options = options
      @thor = thor
      @path = path
    end

    def run
      dsl.job_definitions.each do |_, jd_context|
        jd = Bako::Models::JobDefinition.from_context(jd_context)

        if jd.remote_exists?
          y_or_n = @thor.ask("JobDefinition #{jd.name} seems to exist on remote. would you like to update it? (y/n)")
          next unless y_or_n =~ /y/i
        end

        jd.register
      end

      jobs_to_be_run.each do |job|
        Bako::Models::Job.from_context(job).start
      end
    end

    private

    def jobs_to_be_run
      dsl.jobs.values - dsl.jobs.values.map{|j| j.depends_on_b}.flatten
    end

    def dsl
      @dsl ||= Bako::DSL.parse(File.read(@path))
    end
  end
end
