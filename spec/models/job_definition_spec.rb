require "spec_helper"

require 'bako/models/job'

RSpec.describe Bako::Models::JobDefinition do
  let(:hello_fixture) { File.read(fixture_root.join('hello.rb')) }
  let(:hello_context) {
    Bako::DSL.parse(hello_fixture).job_definitions['hello_def']
  }
  let(:hello_result) {
    Bako::Models::JobDefinition.from_context(hello_context)
  }

  it 'can instanciate from context' do
    expect(hello_result.name).to eq('hello_def')
    expect(hello_result.type).to eq ('container')
  end
end
