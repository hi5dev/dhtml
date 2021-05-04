# frozen_string_literal: true

require 'test_helper'

module DHTML
  class VersionTest < Minitest::Test
    # The officially suggested regular expression for matching semantic version numbers.
    #
    # @see https://semver.org/spec/v2.0.0.html#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string
    # @type [Regexp]
    SEMVER_REGEXP = /
      ^
        # MAJOR.MINOR.PATCH
        (0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)

        # Metadata
        (?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?
        (?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?
      $
    /x

    def test_semantic
      assert_match SEMVER_REGEXP, DHTML::VERSION, "#{DHTML::VERSION.inspect} is not a valid semantic version number"
    end
  end
end
