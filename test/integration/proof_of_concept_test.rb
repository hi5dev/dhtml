# frozen_string_literal: true

require 'test_helper'

class ProofOfConceptTest < Minitest::Test
  module Layout
    include DHTML

    def render
      doctype :html

      html do
        head do
          title { 'Proof of Concept' }
        end
        body do
          yield if block_given?
        end
      end

      finish
    end
  end

  class IndexPage
    include Layout

    def render
      super do
        h1 { 'It works!' }
      end
    end
  end

  def test_index
    page = IndexPage.new

    expected = "<!doctype html><html><head><title>Proof of Concept</title></head><body><h1>It works!</h1></body></html>"

    html = page.render

    assert_equal expected, html.read
  end
end
