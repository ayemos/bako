require "spec_helper"

require 'bako/dsl'
require 'bako/dsl/context'
require 'bako/dsl/context/job'

RSpec.describe Bako::DSL::Context::Job do
  let(:hello_fixture) { 'hello.rb' }
  let(:hello_result) {
    Bako::DSL.parse(File.read(fixture_root.join(hello_fixture))).jobs
  }

  it 'create hello job' do
    expect(hello_result.first.last.name).to eq('hello')
  end
end
