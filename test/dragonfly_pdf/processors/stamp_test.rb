require 'pdf-reader'
require 'test_helper'

describe DragonflyPdf::Processors::Stamp do
  let(:app) { test_app.configure_with(:pdf) }
  let(:content) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:content_stamp) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_stamp.pdf')) }
  let(:processor) { DragonflyPdf::Processors::Stamp.new }

  before { processor.call(content, content_stamp) }

  it { content.analyse(:page_count).must_equal 10 }
  it { PDF::Reader.new(content.path).pages.map(&:text).must_equal %w(STAMP).cycle(10).to_a }
end
