require 'pdf-reader'
require 'test_helper'

describe DragonflyPdf::Processors::Stamp do
  let(:app) { test_app.configure_with(:pdf) }
  let(:processor) { DragonflyPdf::Processors::Stamp.new }
  let(:sample_1) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:sample_stamp) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_stamp.pdf')) }
  let(:text) { PDF::Reader.new(sample_1.path).pages.map(&:text) }

  before { processor.call(sample_1, sample_stamp) }

  it 'has same number of pages' do
    sample_1.analyse(:page_count).must_equal 10
  end

  it 'has the stamp' do
    text.must_equal %w(STAMP).cycle(10).to_a
  end
end
