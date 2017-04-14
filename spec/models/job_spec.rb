require "spec_helper"

require 'bako/models/job'

RSpec.describe Bako::Models::Job do
  let(:hello_fixture) { 'hello.rb' }
  let(:hello_context) {
    Bako::DSL.parse(File.read(fixture_root.join(hello_fixture))).jobs['hello']
  }
  let(:hello_result) {
    Bako::Models::Job.from_context(hello_context)
  }

  it 'can instanciate from context' do
    expect(hello_result.name).to eq('hello')
    expect(hello_result.command).to eq (['echo', 'hello'])
    expect(hello_result.memory).to eq (256)
    expect(hello_result.vcpus).to eq (4)
  end
end
