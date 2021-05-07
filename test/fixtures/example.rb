# frozen_string_literal: true

extend DHTML

doctype :html5

html(lang: 'en') {
  head {
    meta charset: 'utf-8'
    title { 'Example' }
    link rel: 'stylesheet', href: 'style.css'
    script src: 'main.js'
  }
  body {
    div(id: 'main') {
      _p { |i|
        i << "Some of Ruby's internal methods would be overwritten if this library added a method for all the "
        i << "HTML tags. To solve this, the alias for these methods begins with an underscore. At present, "
        i << "there are only two"

        code { '_p' }

        i << h('&')

        code { '_select' }
      }
    }
  }
}
