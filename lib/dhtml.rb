# frozen_string_literal: true

require_relative 'dhtml/document'
require_relative 'dhtml/version'

module DHTML
  include CGI::Util
  include DHTML::Document

  # List of tags that do not require a closing tag.
  #
  # @type [Array<Symbol>]
  VOID_TAGS = %i[area audio base br col hr img input link meta param picture source video].freeze

  # @param [Symbol] tag
  # @return [TrueClass, FalseClass]
  # @since 0.1.0
  def void?(tag)
    VOID_TAGS.include?(tag)
  end

  # An underscore is added to HTML tags that already have Ruby methods. This makes it both easy to remember, and to
  # strip them out
  begin
    alias_method :_p, :write_html_tag
    alias_method :_select, :write_html_tag
  end

  # The HTML tags are aliased to #html_tag, which uses reflection to determine which tag to generate.
  begin
    alias_method :a, :write_html_tag
    alias_method :abbr, :write_html_tag
    alias_method :address, :write_html_tag
    alias_method :area, :write_html_tag
    alias_method :article, :write_html_tag
    alias_method :aside, :write_html_tag
    alias_method :audio, :write_html_tag
    alias_method :b, :write_html_tag
    alias_method :base, :write_html_tag
    alias_method :bdi, :write_html_tag
    alias_method :bdo, :write_html_tag
    alias_method :blockquote, :write_html_tag
    alias_method :body, :write_html_tag
    alias_method :br, :write_html_tag
    alias_method :button, :write_html_tag
    alias_method :canvas, :write_html_tag
    alias_method :caption, :write_html_tag
    alias_method :cite, :write_html_tag
    alias_method :code, :write_html_tag
    alias_method :col, :write_html_tag
    alias_method :colgroup, :write_html_tag
    alias_method :data, :write_html_tag
    alias_method :datalist, :write_html_tag
    alias_method :dd, :write_html_tag
    alias_method :del, :write_html_tag
    alias_method :details, :write_html_tag
    alias_method :dfn, :write_html_tag
    alias_method :dialog, :write_html_tag
    alias_method :div, :write_html_tag
    alias_method :dl, :write_html_tag
    alias_method :dt, :write_html_tag
    alias_method :em, :write_html_tag
    alias_method :embed, :write_html_tag
    alias_method :fieldset, :write_html_tag
    alias_method :figcaption, :write_html_tag
    alias_method :figure, :write_html_tag
    alias_method :footer, :write_html_tag
    alias_method :form, :write_html_tag
    alias_method :h1, :write_html_tag
    alias_method :h2, :write_html_tag
    alias_method :h3, :write_html_tag
    alias_method :h4, :write_html_tag
    alias_method :h5, :write_html_tag
    alias_method :h6, :write_html_tag
    alias_method :head, :write_html_tag
    alias_method :header, :write_html_tag
    alias_method :hgroup, :write_html_tag
    alias_method :hr, :write_html_tag
    alias_method :html, :write_html_tag
    alias_method :i, :write_html_tag
    alias_method :iframe, :write_html_tag
    alias_method :img, :write_html_tag
    alias_method :input, :write_html_tag
    alias_method :ins, :write_html_tag
    alias_method :kbd, :write_html_tag
    alias_method :label, :write_html_tag
    alias_method :legend, :write_html_tag
    alias_method :li, :write_html_tag
    alias_method :link, :write_html_tag
    alias_method :main, :write_html_tag
    alias_method :map, :write_html_tag
    alias_method :mark, :write_html_tag
    alias_method :meta, :write_html_tag
    alias_method :meter, :write_html_tag
    alias_method :nav, :write_html_tag
    alias_method :noscript, :write_html_tag
    alias_method :object, :write_html_tag
    alias_method :ol, :write_html_tag
    alias_method :optgroup, :write_html_tag
    alias_method :option, :write_html_tag
    alias_method :output, :write_html_tag
    alias_method :param, :write_html_tag
    alias_method :picture, :write_html_tag
    alias_method :pre, :write_html_tag
    alias_method :progress, :write_html_tag
    alias_method :q, :write_html_tag
    alias_method :rb, :write_html_tag
    alias_method :rp, :write_html_tag
    alias_method :rt, :write_html_tag
    alias_method :rtc, :write_html_tag
    alias_method :ruby, :write_html_tag
    alias_method :s, :write_html_tag
    alias_method :samp, :write_html_tag
    alias_method :script, :write_html_tag
    alias_method :section, :write_html_tag
    alias_method :slot, :write_html_tag
    alias_method :small, :write_html_tag
    alias_method :source, :write_html_tag
    alias_method :span, :write_html_tag
    alias_method :strong, :write_html_tag
    alias_method :style, :write_html_tag
    alias_method :sub, :write_html_tag
    alias_method :summary, :write_html_tag
    alias_method :sup, :write_html_tag
    alias_method :table, :write_html_tag
    alias_method :tbody, :write_html_tag
    alias_method :td, :write_html_tag
    alias_method :template, :write_html_tag
    alias_method :textarea, :write_html_tag
    alias_method :tfoot, :write_html_tag
    alias_method :th, :write_html_tag
    alias_method :thead, :write_html_tag
    alias_method :time, :write_html_tag
    alias_method :title, :write_html_tag
    alias_method :tr, :write_html_tag
    alias_method :track, :write_html_tag
    alias_method :u, :write_html_tag
    alias_method :ul, :write_html_tag
    alias_method :var, :write_html_tag
    alias_method :video, :write_html_tag
    alias_method :wbr, :write_html_tag
  end

  def html(**attributes, &inner_html)
    write_html_tag(tag: :html, **attributes, &inner_html)

    document.tap(&:rewind)
  end
end
