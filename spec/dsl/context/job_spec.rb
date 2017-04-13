require "spec_helper"

require 'bako/dsl'
require 'bako/dsl/context'
require 'bako/dsl/context/job'

RSpec.describe Bako::DSL::Context::Job do
  let(:hello_fixture) { 'hello.job' }
  let(:hello_result) {
    Bako::DSL.parse(File.read(fixture_root.join(hello_fixture))).to_h
  }

  let(:hello_expected) {
    {
      jobs: {
        'hello' => {
          name: 'hello',
          param: {}
        }
      }
    }
  }

  it 'create hello job' do
    expect(hello_result).to eq(hello_expected)
  end
end
