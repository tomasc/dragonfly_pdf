require 'test_helper'

describe DragonflyPdf::Processors::Convert do
  let(:app) { test_app.configure_with(:pdf) }
  let(:processor) { DragonflyPdf::Processors::Convert.new }
  let(:content) { app.fetch_file SAMPLES_DIR.join('sample_pages.pdf') }

  describe 'SUPPORTED_OUTPUT_FORMATS' do
    DragonflyPdf::SUPPORTED_OUTPUT_FORMATS.each do |format|
      it(format) do
        result = content.convert(1, '600x', format: format)
        _(result.ext).must_equal format
        _(result.mime_type).must_equal Rack::Mime.mime_type(".#{format}")
        _(result.size).must_be :>, 0
        _(result.tempfile.path).must_match /\.#{format}\z/
      end
    end
  end

  describe 'url' do
    let (:url_attributes) { OpenStruct.new }
    before { processor.update_url(url_attributes, 1) }
    it { _(url_attributes.ext).must_equal 'png' }
  end
end
