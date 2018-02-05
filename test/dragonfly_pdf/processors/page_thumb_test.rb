require 'test_helper'

describe DragonflyPdf::Processors::PageThumb do
  let(:app) { test_app.configure_with(:pdf) }
  let(:sample) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }

  let(:processor) { DragonflyPdf::Processors::PageThumb.new }

  describe 'formats' do
    let (:url_attributes) { OpenStruct.new }

    describe 'default' do
      before { processor.call(sample, 1, '600x') }

      it 'converts the PDF to a JPG by default' do
        sample.ext.must_equal 'jpg'
      end

      it 'updates the file meta format to JPG by default' do
        sample.meta['format'].must_equal 'jpg'
      end

      it 'updates the url extension to JPG by default' do
        processor.update_url(url_attributes, 1)
        url_attributes.ext.must_equal 'jpg'
      end
    end
  end
end
