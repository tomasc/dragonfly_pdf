require 'test_helper'

describe DragonflyPdf::Processors::SubsetFonts do
  let(:app) { test_app.configure_with(:pdf) }
  let(:processor) { DragonflyPdf::Processors::SubsetFonts.new }
  let(:sample_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }

  it 'returns PDF by default' do
    skip 'not sure how to test this'
    processor.call(sample_pages, 1)
  end
end
