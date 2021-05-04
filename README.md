# DHTML

Generate HTML using Ruby. Works really well for building web applications (Rack, Rails, Sinatra, etc).

Here's an example of an entire document being generated using the DSL:

```ruby
class HtmlDocument
  include DHTML

  def render
    doctype :html5

    html lang: I18n.locale do
      head do
        meta charset: 'utf-8'
        title I18n.t('title')
        link rel: 'stylesheet', href: 'style.css'
        script src: 'main.js'
      end
      body do
        div id: 'app' do
          h1 { 'Hello, world!' }
        end
      end
    end
  end
end
```

Here's how to test the above document with Minitest:

```ruby
class HtmlDocumentTest < Minitest::Test
  include DHTML::Test::Methods

  def setup
    I18n.locale = 'en'
    @html = HtmlDocument.new.render
  end

  def test_html5
    assert_html @html, -> { doctype(:html5) }, singleton: true
  end

  def test_locale
    assert_html @html, -> { html(lang: 'en') }, ignore_inner: true
  end

  def test_charset
    assert_html @html, -> { meta(charset: 'utf-8') }
  end

  def test_title
    assert_html @html, -> { title('Testing') }
  end

  def test_stylesheet
    assert_html @html, -> { link(href: 'style.css') }, all_attributes: false
  end

  def test_script
    assert_html @html, -> { script(src: 'main.js') }
  end

  def test_app_div
    assert_html @html, -> { div(id: 'main') }, ignore_inner: true, within: %i[html body]
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hi5dev/dhtml.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
