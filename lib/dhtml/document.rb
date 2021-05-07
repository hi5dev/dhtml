# frozen_string_literal: true

require 'cgi'
require 'cgi/html'

module DHTML
  module Document
    include CGI::Util

    # Snag the HTML doctype tags from the CGI class.
    begin
      # @type [String]
      # @since 0.1.0
      HTML3_DOCTYPE = Class.new { extend CGI::Html3 }.doctype

      # @type [String]
      # @since 0.1.0
      HTML4_DOCTYPE = Class.new { extend CGI::Html4 }.doctype

      # @type [String]
      # @since 0.1.0
      HTML4_FR_DOCTYPE = Class.new { extend CGI::Html4Fr }.doctype

      # @type [String]
      # @since 0.1.0
      HTML4_TR_DOCTYPE = Class.new { extend CGI::Html4Tr }.doctype

      # @type [String]
      # @since 0.1.0
      HTML5_DOCTYPE = Class.new { extend CGI::Html5 }.doctype.downcase
    end

    # Writes the HTML doctype.
    #
    # @param [Symbol] type of document
    # @return [Integer] number of bytes written to the document.
    def doctype(type)
      tag = case type
      when :html3
        HTML3_DOCTYPE
      when :html4
        HTML4_DOCTYPE
      when :html4_framesets
        HTML4_FR_DOCTYPE
      when :html4_transitional
        HTML4_TR_DOCTYPE
      when :html5
        HTML5_DOCTYPE
      else
        fail ArgumentError, "unsupported doctype: #{type.inspect}"
      end

      document.write(tag)
    end

    # The document is written to this buffer.
    #
    # @return [StringIO]
    # @since 0.1.0
    def document
      @document ||= StringIO.new
    end

    # @param [Symbol, String] name
    # @param [Symbol, String] value
    # @return [String]
    # @since 0.1.0
    def html_attribute(name, value)
      [h(name.to_s), h(value.to_s).inspect].join('=')
    end

    # @param [Hash] attributes
    # @return [String]
    def html_attributes(attributes)
      # noinspection RubyYardParamTypeMatch
      attributes.inject([]) { _1 << html_attribute(_2[0], _2[1]) }.join(' ')
    end

    # @!attribute [String] tag
    # @!attribute [Hash] attributes
    # @return [Integer] Number of bytes written to the stream.
    def write_html_element(tag, attributes = {})
      document << '<'
      document << tag
      document << " #{html_attributes(attributes)}" unless attributes.empty?
      document << '>'
    end

    # Write a tag to the HTML document.
    #
    # @param [Symbol] tag name.
    # @param [Hash] attributes for the tag.
    # @param [Proc] inner_html to include in the tag.
    # @return [void]
    # @since 0.1.0
    def write_html_tag(tag: __callee__, **attributes, &inner_html)
      # Remove the underscore prefix added to prevent conflicts with internal Ruby methods.
      tag = tag.to_s
      tag = tag[1..-1] if tag[0] == '_'

      # Opening tag with its HTML attributes - e.g. <div id="main">
      write_html_element(tag, attributes)

      # Capture the inner HTML.
      content = inner_html&.call(document)

      # Write the inner HTML to the document when present.
      document.write(content) if content.is_a?(String)

      # Close the tag when necessary.
      document.write("</#{tag}>") if content.is_a?(String) || block_given? || !void?(tag.to_sym)
    end
  end
end
