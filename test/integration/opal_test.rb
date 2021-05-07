# frozen_string_literal: true

require 'test_helper'

require 'opal'

require 'cgi'

class OpalTest < Minitest::Test
  include TestHelper

  def setup
    Opal.use_gem('dhtml')

    Opal.append_path File.expand_path(File.join('..', 'fixtures'), __dir__)

    code = Opal::Builder.build('opal_example.rb').to_s

    @file = Tempfile.new.tap { _1 << code }
  end

  def teardown
    @file.delete
  end

  def test_opal_eval
    actual = CGI.pretty(`node #{@file.path}`)

    expected = read_fixture('example.html')

    assert_equal no_ws(expected), no_ws(actual)
  end
end
