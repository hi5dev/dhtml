# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(File.join('..', 'lib'), __dir__)

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
