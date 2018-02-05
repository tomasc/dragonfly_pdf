require 'test_helper'

describe DragonflyPdf::Processors::Convert do
  let(:app) { test_app.configure_with(:pdf) }
  let(:sample) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }

  let(:processor) { DragonflyPdf::Processors::Convert.new }

  describe 'formats' do
    let (:url_attributes) { OpenStruct.new }

    describe 'default' do
      before { processor.call(sample, 1, '600x') }

      it 'converts the PDF to a PNG by default' do
        sample.ext.must_equal 'png'
      end

      it 'updates the file meta format to PNG by default' do
        sample.meta['format'].must_equal 'png'
      end

      it 'updates the url extension to PNG by default' do
        processor.update_url(url_attributes, 1)
        url_attributes.ext.must_equal 'png'
      end
    end

    describe 'svg' do
      before { processor.call(sample, 1, '600x', format: :svg) }

      it 'converts the PDF to an SVG' do
        sample.ext.must_equal 'svg'
      end

      it 'updates the file meta format to SVG' do
        sample.meta['format'].must_equal 'svg'
      end

      it 'updates the url extension to SVG' do
        processor.update_url(url_attributes, 1, '', format: :svg)
        url_attributes.ext.must_equal 'svg'
      end
    end
  end
end
