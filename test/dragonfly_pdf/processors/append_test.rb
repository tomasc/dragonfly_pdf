require 'test_helper'

describe DragonflyPdf::Processors::Append do
  let(:app) { test_app.configure_with(:pdf) }
  let(:processor) { DragonflyPdf::Processors::Append.new }
  let(:sample_1) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:sample_2) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages_with_bleed.pdf')) }

  before { processor.call(sample_1, [sample_2]) }

  it 'has total number of pages' do
    sample_1.analyse(:page_count).must_equal 11
  end
end
