require 'test_helper'

describe DragonflyPdf::Processors::Convert do
  let(:app) { test_app.configure_with(:pdf) }
  let(:content) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:processor) { DragonflyPdf::Processors::Convert.new }

  describe 'formats' do
    let (:url_attributes) { OpenStruct.new }

    describe 'default' do
      before do
        processor.call(content, 1, '600x')
        processor.update_url(url_attributes, 1)
      end

      it { content.ext.must_equal 'png' }
      it { content.meta['format'].must_equal 'png' }
      it { url_attributes.ext.must_equal 'png' }
    end

    describe 'svg' do
      let(:format) { 'svg' }

      before do
        processor.call(content, 1, '600x', format: format)
        processor.update_url(url_attributes, 1, '', format: format)
      end

      it { content.ext.must_equal format }
      it { content.meta['format'].must_equal format }
      it { url_attributes.ext.must_equal format }
    end
  end
end
