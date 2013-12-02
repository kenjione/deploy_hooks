# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deploy_hooks/version'

Gem::Specification.new do |spec|
  spec.name          = "deploy_hooks"
  spec.version       = DeployHooks::VERSION
  spec.authors       = ["Alex Chernyshev"]
  spec.email         = ["alex.kenjione@gmail.com"]
  spec.description   = %q{User can define tasks which will start before or after deployment}
  spec.summary       = %q{Heroku deployment hooks}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "tasks"]

  spec.add_dependency "heroku"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end