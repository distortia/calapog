# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'calapog/version'

Gem::Specification.new do |spec|
  spec.name          = "calapog"
  spec.version       = Calapog::VERSION
  spec.authors       = ["Nick Stalter"]
  spec.email         = ["nickstalter@gmail.com"]
  spec.summary       = %q{Calabash Page Object Generator to be paired with my boilerplate}
  spec.description   = %q{CALAbash Page Object Generator is to be used for generating cross platform pages to cut down on the amount of code we have to write}
  spec.homepage      = "https://gitlab.com/distortia/calapog"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', "~> 0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
