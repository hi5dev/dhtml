# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path(File.join('..', 'Gemfile'), __dir__)

require 'bundler/setup'

Bundler.require

require 'dhtml'

require 'minitest/autorun'

module TestHelper
  private

  def read_fixture(*name)
    fixture_path = File.expand_path(File.join('fixtures', *name), __dir__)

    File.read(fixture_path)
  end

  def no_ws(text)
    text
      .split("\n")
      .map(&:strip)
      .reject(&:empty?)
      .join("\n")
  end
end
