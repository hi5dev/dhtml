# DHTML

A fast, simple, and elegant DSL for generating HTML using Ruby that is compatible with [Opal](https://opalrb.com/).

Here's an example:

```ruby
extend DHTML

doctype :html

html(lang: 'en') {
  head {
    meta charset: 'utf-8'
    title { 'Example' }
    link rel: 'stylesheet', href: 'style.css'
    script src: 'main.js'
  }
  body {
    div(id: 'main') {
      _p { <<~TEXT }
        Some of Ruby's internal methods would be overwritten if this library added a method for all the HTML tags. To
        solve this, the alias for these methods begins with an underscore:
      TEXT

      ol {
        li { code { '_p' } }
        li { code { '_select' } }
      }
    }
  }
}

puts read_html
```

## Proof of Concept

Using Ruby to generate HTML makes it possible to write modular, easily testable views. Here's a simple example:

```ruby
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

page = IndexPage.new

html = page.render

puts html.read

# => "<!doctype html><html><head><title>Proof of Concept</title></head><body><h1>It works!</h1></body></html>"
```

It's easy to see how that could be plugged into many Ruby web frameworks. Here's how the above example can work with
Rack:

```ruby
run -> (_env) do
  [200, { Rack::CONTENT_TYPE => 'text/html' }, IndexPage.new.render]
end
```

## Development

A `Dockerfile` and Docker Compose configuration is provided to simplify the onboarding process. After cloning this 
repository, all you have to do to get started is run the tests with:

    $ docker-compose run test

You can log into the container with:

    $ docker-compose run ruby ash

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hi5dev/dhtml. Make sure to add your 
contact information to `spec.authors` and `spec.email` in the gemspec file if you do contribute.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
