# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bako/version'

Gem::Specification.new do |spec|
  spec.name          = "bako"
  spec.version       = Bako::VERSION
  spec.authors       = ["Yuichiro Someya"]
  spec.email         = ["ayemos.y@gmail.com"]

  spec.summary       = %q{AWS Batch DSL and a set of cli tool.}
  spec.description   = %q{AWS Batch DSL and a set of cli tool.}
  spec.homepage      = "https://github.com/ayemos/bako"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "awesome_print"

  spec.add_dependency "aws-sdk", "~> 2"
  spec.add_dependency "thor", "~> 0.19"
end
