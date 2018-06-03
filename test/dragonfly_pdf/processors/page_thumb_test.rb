require 'test_helper'

describe DragonflyPdf::Processors::PageThumb do
  let(:app) { test_app.configure_with(:pdf) }
  let(:content) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:processor) { DragonflyPdf::Processors::PageThumb.new }

  describe 'formats' do
    let (:url_attributes) { OpenStruct.new }

    describe 'default' do
      before do
        processor.call(content, 1, '600x')
        processor.update_url(url_attributes, 1)
      end

      it { content.ext.must_equal 'jpg' }
      it { content.meta['format'].must_equal 'jpg' }
      it { url_attributes.ext.must_equal 'jpg' }
    end
  end

  describe 'tempfile has extension' do
    before { processor.call(content, 1, '600x') }
    it { content.tempfile.path.must_match /\.jpg\z/ }
  end
end
