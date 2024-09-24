# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name        = 'chbr'
  spec.version     = '0.2.0'
  spec.executables << 'chbr'
  spec.summary     = 'Change branch tool'
  spec.description = 'A simple CLI tool to change branches in a git repositoy. ' \
                     'You can also delete local branches.'
  spec.authors     = ['thestbar']
  spec.email       = 'stavrosbarousis@gmail.com'
  spec.files       = ['lib/chbr.rb']
  spec.homepage    = 'https://rubygems.org/gems/chbr'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'git', '~> 2.3'
  spec.add_dependency 'optparse', '~> 0.4'
end