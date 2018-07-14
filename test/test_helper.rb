require 'bundler/setup'

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/spec'

require 'dragonfly'
require 'dragonfly_pdf'

SAMPLES_DIR = Pathname.new(File.expand_path('../../samples', __FILE__))

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

def test_app(name = nil)
  app = Dragonfly::App.instance(name).tap do |app|
    app.datastore = Dragonfly::MemoryDataStore.new
    app.secret = 'test secret'
  end
end
