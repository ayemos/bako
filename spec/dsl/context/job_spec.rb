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

  let(:command_fixture) { File.read(fixture_root.join('command.rb')) }
  let(:command_result_space) {
    Bako::DSL.parse(command_fixture).jobs['command_space']
  }
  let(:command_result_int) {
    Bako::DSL.parse(command_fixture).jobs['command_int']
  }

  it 'can parse job context' do
    expect(hello_result.name).to eq('hello')
    expect(hello_result.result[:command]).to eq (['echo', 'hello'])
    expect(hello_result.result[:memory]).to eq (256)
    expect(hello_result.result[:vcpus]).to eq (4)
  end

  it 'raise when missing required params' do
    expect{Bako::DSL.parse(missing_def_fixture)}.to raise_error(Bako::InvalidArgumentError)
    expect{Bako::DSL.parse(missing_queue_fixture)}.to raise_error(Bako::InvalidArgumentError)
  end

  it 'can parse job commands' do
    expect(command_result_space.result[:command]).to eq(['echo', 'hello'])
    expect(command_result_int.result[:command]).to eq(['sleep', '10'])
  end
end
