# frozen_string_literal: true

require 'test_helper'

class DHTMLTest < Minitest::Test
  def test_no_conflicting_names
    DHTML
      .instance_methods(false)
      .each { refute_includes Kernel.methods, _1, "#{_1.inspect} is a Kernel method" }
  end

  def test_underscored_tags
    %i[p select].each do
      assert_includes DHTML.instance_methods(false), :"_#{_1}", "#{_1} is not aliased with an underscore"
    end
  end

  def test_document
    expected = read_fixture('example.html')

    actual = Class.new.class_eval(read_fixture('example.rb')).read

    assert_equal no_ws(expected), no_ws(CGI.pretty(actual))
  end

  private

  def read_fixture(*name)
    fixture_path = File.expand_path(File.join('..', 'fixtures', *name), __dir__)

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
