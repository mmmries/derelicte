# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'derelicte/version'

Gem::Specification.new do |spec|
  spec.name          = "derelicte"
  spec.version       = Derelicte::VERSION
  spec.authors       = ["Michael Ries"]
  spec.email         = ["michael@riesd.com"]
  spec.summary       = "JRuby specific css inliner aiming for maximum performance"
  spec.description   = "A JRuby specific gem that takes an html template and css file and inlines the css rules into style attributes. This is mostly useful for sending emails."
  spec.homepage      = "https://github.com/mmmries/derelicte"
  spec.license       = "MIT"
  spec.platform      = "java"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "pry-nav"
end
