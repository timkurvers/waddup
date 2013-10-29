if RUBY_VERSION >= '1.9.3'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start
end

require 'waddup'

Dir['./spec/support/**/*.rb'].sort.each { |file| require file }
