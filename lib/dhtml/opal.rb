# frozen_string_literal: true

# Only continue when not running in Opal, and the gem is available.
return if RUBY_ENGINE == 'opal' || !defined?(Opal)

# Add the library to the Opal load path when it's available.
Opal.append_path File.expand_path(File.join('..', '..'), __FILE__)
