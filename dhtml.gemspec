# frozen_string_literal: true

require_relative 'lib/dhtml/version'

Gem::Specification.new do |spec|
  spec.name = 'dhtml'
  spec.version = DHTML::VERSION
  spec.authors = ['Travis Haynes']
  spec.email = %w[travis@hi5dev.com]

  spec.summary = 'Generate HTML using a simple and clean Ruby DSL.'
  spec.description = spec.summary
  spec.homepage = 'https://github.com/hi5dev/dhtml'
  spec.license = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/hi5dev/dhtml/blob/master/CHANGELOG.md'

  spec.files = Dir[File.expand_path(File.join('lib', '**', '*.rb'), __dir__)] + %w[
    CHANGELOG.md
    Gemfile
    Gemfile.lock
    LICENSE.txt
    README.md
  ]

  spec.require_paths = %w[lib]
end
