require "spec_helper"

require 'bako/dsl'
require 'bako/dsl/context'
require 'bako/dsl/context/job_definition'

RSpec.describe Bako::DSL::Context::JobDefinition do
  let(:hello_fixture) { 'hello.rb' }
  let(:hello_result) {
    Bako::DSL.parse(File.read(fixture_root.join(hello_fixture))).jobs['hello']
  }

  it 'create hello job' do
    expect(hello_result.name).to eq('hello')
    expect(hello_result.command_b).to eq (['echo', 'hello'])
    expect(hello_result.memory_b).to eq (256)
    expect(hello_result.vcpus_b).to eq (4)
  end
end
