# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cricketer_stats/version'

Gem::Specification.new do |spec|
  spec.name          = "cricketer_stats"
  spec.version       = CricketerStats::VERSION
  spec.authors       = ["hameedfiaz"]
  spec.email         = ["rmahameed005@gmail.com"]
  spec.summary       = "A short summary"
  spec.description   = "A longer description"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "mechanize", "~> 2.6.0"
end
