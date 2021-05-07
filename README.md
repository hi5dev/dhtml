# DHTML

A fast, simple, and elegant DSL for generating HTML using Ruby.

Here's an example:

```ruby
include DHTML

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
        i << "there are only two:"

        code { '_p' }

        i << h('&')

        code { '_select' }
      }
    }
  }
}
```

You can retrieve the generated HTML in one of two ways:

1. `html` returns a `StringIO` object with the cursor at 0.
2. `document` contains is the same `StringIO` object `html` returns, with the cursor at the end.

Rewind `document` before you read it, or it will appear to be empty:

```ruby
document.tap(&:rewind).read
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hi5dev/dhtml.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
