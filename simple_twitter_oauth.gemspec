# coding: utf-8
lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'simple_twitter_oauth/version'

Gem::Specification.new do |spec|
  spec.name = 'simple_twitter_oauth'
  spec.version = SimpleTwitterOAuth::VERSION
  spec.authors = ['Odin Dutton']
  spec.email = ['odindutton@gmail.com']
  spec.summary = 'A really simple Twitter OAuth library.'
  spec.homepage = 'https://github.com/twe4ked/simple_twitter_oauth'
  spec.license = 'MIT'
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.require_paths = ['lib']

  spec.add_dependency 'oauth', '~> 0.5.1'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
