# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tildone/version'

Gem::Specification.new do |spec|
  spec.name          = 'tildone'
  spec.version       = Tildone::VERSION
  spec.authors       = ['Trevor Parker']
  spec.email         = ['trevor@trevorparker.com']
  spec.summary       = %q{A simple task management framework.}
  spec.description   = %q{A simple task management framework.}
  spec.homepage      = 'https://github.com/trevorparker/tildone'
  spec.license       = 'Modified BSD'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mercenary'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
