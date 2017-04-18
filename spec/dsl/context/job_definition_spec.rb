require "spec_helper"

require 'bako/dsl'
require 'bako/dsl/context'
require 'bako/dsl/context/job_definition'

RSpec.describe Bako::DSL::Context::JobDefinition do
  let(:hello_fixture) { File.read(fixture_root.join('hello.rb')) }
  let(:hello_result) {
    Bako::DSL.parse(hello_fixture).result[:job_definitions]['hello_def']
  }

  let(:missing_type_fixture) { File.read(fixture_root.join('missing_type.rb')) }

  it 'can parse job_definition' do
    expect(hello_result.name).to eq('hello_def')
  end

  it 'raise when missing required params' do
    expect{Bako::DSL.parse(missing_type_fixture)}.to raise_error(Bako::InvalidArgumentError)
  end
end
