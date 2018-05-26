require 'test_helper'

describe DragonflyPdf::Processors::SubsetFonts do
  let(:app) { test_app.configure_with(:pdf) }
  let(:content) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:processor) { DragonflyPdf::Processors::SubsetFonts.new }

  it 'returns PDF by default' do
    skip 'not sure how to test this'
    processor.call(content, 1)
  end
end
