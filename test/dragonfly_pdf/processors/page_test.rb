require 'test_helper'

describe DragonflyPdf::Processors::Page do
  let(:app) { test_app.configure_with(:pdf) }
  let(:content) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:processor) { DragonflyPdf::Processors::Page.new }

  it { proc { processor.call(content, 0) }.must_raise DragonflyPdf::PageNotFound }
  it { proc { processor.call(content, 11) }.must_raise DragonflyPdf::PageNotFound }

  describe 'single pages' do
    before { processor.call(content, 1) }
    it { content.analyse(:page_count).must_equal 1 }
  end

  describe 'tempfile has extension' do
    it { processor.call(content, 1).tempfile.path.must_match /\.pdf\z/ }
  end
end
