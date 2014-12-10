require 'rspec'

# Bundler.require(:development)

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

require 'map_gather'

RSpec.configure do |config|
  # some (optional) config here
end
