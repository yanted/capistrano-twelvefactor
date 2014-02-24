# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/twelvefactor/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-twelvefactor'
  spec.version       = Capistrano::Twelvefactor::VERSION
  spec.authors       = ['Mario Behrendt']
  spec.email         = ['info@yanted.com']
  spec.summary       = 'Capistrano tasks to change environment config on remote hosts'
  spec.description   = 'Capistrano tasks to change environment config on remote hosts'
  spec.homepage      = 'http://www.github.com/yanted/capistrano-twelvefactor'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.4'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'capistrano'
end
