# frozen_string_literal: true

require 'stringio'

module DHTML
  # Provides methods for generating HTML.
  #
  # @since 0.1.0
  module Document
    # Most commonly used HTML escape sequences.
    #
    # @type [Hash<String => String>]
    # @since 0.1.0
    ESCAPE_HTML = {
      "'" => '&#x27;',
      '"' => '&quot;',
      '&' => '&amp;',
      '/' => '&#x2F;',
      '<' => '&lt;',
      '>' => '&gt;',
    }

    # Regular expression that matches the most common characters that need to be escaped in HTML strings.
    #
    # @type [Regexp]
    # @since 0.1.0
    ESCAPE_HTML_PATTERN = Regexp.union(*ESCAPE_HTML.keys)

    # Writes the HTML doctype.
    #
    # @param [Symbol] type of document
    # @return [Integer] number of bytes written to the document.
    # @since 0.1.0
    def doctype(type)
      tag = case type
      when :html3
        %|<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">|
      when :html4
        %|<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">|
      when :html4_framesets, :html4_fr
        %|<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">|
      when :html4_transitional, :html4_tr
        %|<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">|
      when :html5, :html
        %|<!doctype html>|
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

    # Rewinds the document so it can be read.
    #
    # @return [StringIO]
    # @since 0.1.0
    def finish
      document.tap(&:rewind)
    end

    # Generates an HTML attribute (e.g. +class="form"+).
    #
    # @param [Symbol, String] name
    # @param [Symbol, String] value
    # @return [String]
    # @since 0.1.0
    def html_attribute(name, value)
      [h(name.to_s), h(value.to_s).inspect].join('=')
    end

    # Generates a string of HTML attributes from a Hash.
    #
    # @param [Hash] attributes
    # @return [String]
    # @since 0.1.0
    def html_attributes(attributes)
      # noinspection RubyYardParamTypeMatch
      attributes.inject([]) { _1 << html_attribute(_2[0], _2[1]) }.join(' ')
    end

    # Escape ampersands, brackets and quotes for HTML.
    #
    # @param [String] string to escape.
    # @return [String] HTML escaped string.
    # @since 0.1.0
    def html_escape(string)
      string.to_s.gsub(ESCAPE_HTML_PATTERN) { ESCAPE_HTML[_1] }
    end

    alias_method :h, :html_escape

    # Reads and formats the document in a way presentable to a human.
    #
    # @note Not available to Opal.
    # @param [String] indent string.
    # @return [String]
    # @since 0.1.4
    def pretty_html(indent: ' ' * 2)
      require 'cgi' unless defined?(CGI)

      CGI.pretty(read_html, indent)
    end if RUBY_ENGINE != 'opal'

    # Reads the entire HTML document.
    #
    # @return [String]
    # @since 0.1.0
    def read_html
      document.tap(&:rewind).read
    end

    # Clears all content from the document.
    #
    # @return [StringIO]
    # @since 0.1.1
    def reset
      document.close
      document.reopen
    end

    # Writes the opening element for the given HTML tag to the document.
    #
    # @!attribute [String] tag
    # @!attribute [Hash] attributes
    # @return [void]
    # @since 0.1.0
    def write_html_element(tag, attributes = {})
      document << '<'
      document << tag
      document << " #{html_attributes(attributes)}" unless attributes.empty?
      document << '>'

      nil
    end

    # Write a tag to the HTML document.
    #
    # @param [Symbol] tag name.
    # @param [Hash] attributes for the tag.
    # @param [Proc] inner_html to include in the tag.
    # @return [void]
    # @since 0.1.0
    def write_html_tag(tag: __callee__, **attributes, &inner_html)
      # Ensure the method isn't being called directly.
      fail ArgumentError, 'invalid tag' if tag == :write_html_tag

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

      nil
    end
  end
end
