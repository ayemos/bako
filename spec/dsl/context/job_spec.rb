require "spec_helper"

require 'bako/dsl'
require 'bako/dsl/context'
require 'bako/dsl/context/job_definition'

RSpec.describe Bako::DSL::Context::Job do
  let(:hello_fixture) { File.read(fixture_root.join('hello.rb')) }
  let(:hello_result) {
    Bako::DSL.parse(hello_fixture).jobs['hello']
  }

  let(:missing_def_fixture) { File.read(fixture_root.join('missing_def.rb')) }
  let(:missing_queue_fixture) { File.read(fixture_root.join('missing_queue.rb')) }

  it 'can parse job context' do
    expect(hello_result.name).to eq('hello')
    expect(hello_result.command_b).to eq (['echo', 'hello'])
    expect(hello_result.memory_b).to eq (256)
    expect(hello_result.vcpus_b).to eq (4)
  end

  it 'raise when missing required params' do
    expect{Bako::DSL.parse(missing_def_fixture)}.to raise_error(Bako::InvalidArgumentError)
    expect{Bako::DSL.parse(missing_queue_fixture)}.to raise_error(Bako::InvalidArgumentError)
  end
end
