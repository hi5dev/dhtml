# frozen_string_literal: true

require 'test_helper'

class ProofOfConceptTest < Minitest::Test
  include TestHelper

  module Layout
    include DHTML

    def inner_body
    end

    def render
      reset if document.length > 0

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
    expected = read_fixture('proof_of_concept.html').strip

    page = IndexPage.new
    assert_equal expected, page.render.read

    page.reset
    assert_equal expected, page.render.read
  end

  def test_inner_body
    page = IndexPage.new.tap(&:inner_body)

    assert_equal '<h1>It works!</h1>', page.read_html
  end
end

