require 'test_helper'

describe DragonflyPdf::Processors::Page do
  let(:app) { test_app.configure_with(:pdf) }
  let(:processor) { DragonflyPdf::Processors::Page.new }
  let(:sample_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }

  it 'raises PageNotFound error' do
    proc { processor.call(sample_pages, 0) }.must_raise DragonflyPdf::PageNotFound
    proc { processor.call(sample_pages, 11) }.must_raise DragonflyPdf::PageNotFound
  end

  describe 'single pages' do
    it 'renders page' do
      processor.call(sample_pages, 1)
      sample_pages.analyse(:page_count).must_equal 1
    end
  end
end
