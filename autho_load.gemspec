# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autho_load/version'

Gem::Specification.new do |spec|
  spec.name          = "autho_load"
  spec.version       = AuthoLoad::VERSION
  spec.authors       = ["Rebecca Mengell"]
  spec.email         = ["rmengell@comcast.net"]
  spec.description   = %q{Authrize and load resource}
  spec.summary       = %q{Authorization and resource load  inspired by CanCan and Rails Antipaterns}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
