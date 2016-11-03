$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simple_twitter_oauth'

RSpec.configure do |config|
  config.disable_monkey_patching!
end
