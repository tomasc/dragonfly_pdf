require 'test_helper'

module DragonflyPdf
  describe Plugin do

    let(:app) { test_app.configure_with(:pdf) }
    let(:pdf) { app.fetch_file(SAMPLES_DIR.join('sample_pages.pdf')) }

    # ---------------------------------------------------------------------

    describe 'analysers' do
      it 'adds #page_count' do
        pdf.must_respond_to :page_count
      end
      it 'adds #spread_count' do
        pdf.must_respond_to :spread_count
      end
      it 'adds #page_numbers' do
        pdf.must_respond_to :page_numbers
      end
      it 'adds #widths' do
        pdf.must_respond_to :widths
      end
      it 'adds #heights' do
        pdf.must_respond_to :heights
      end
      it 'adds #aspect_ratios' do
        pdf.must_respond_to :aspect_ratios
      end
      it 'adds #info' do
        pdf.must_respond_to :info
      end
    end

  end
end