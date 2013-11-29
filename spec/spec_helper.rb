require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require 'waddup'

Dir['./spec/support/**/*.rb'].sort.each { |file| require file }

RSpec.configure do |config|

  # Helper modules
  config.extend ShellMock

  config.before(:each) do
    ShellMock.apply!
  end

  # Allow focussing on individual specs
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # Run specs in random order to surface order dependencies
  config.order = 'random'

end
