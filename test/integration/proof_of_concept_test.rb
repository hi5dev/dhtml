# frozen_string_literal: true

require 'test_helper'

class ProofOfConceptTest < Minitest::Test
  module Layout
    include DHTML

    def inner_body
    end

    def render
      doctype :html

      html do
        head do
          title { 'Proof of Concept' }
        end
        body do
          inner_body
        end
      end

      finish
    end
  end

  class IndexPage
    include Layout

    def inner_body
      h1 { 'It works!' }
    end
  end

  def test_index
    page = IndexPage.new

    expected = "<!doctype html><html><head><title>Proof of Concept</title></head><body><h1>It works!</h1></body></html>"

    html = page.render

    assert_equal expected, html.read
  end

  def test_inner_body
    page = IndexPage.new.tap(&:inner_body)

    assert_equal '<h1>It works!</h1>', page.read_html
  end
end

