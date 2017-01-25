require 'test_helper'

module DragonflyPdf
  describe Plugin do
    let(:app) { test_app.configure_with(:pdf) }
    let(:pdf) { app.fetch_file(SAMPLES_DIR.join('sample_pages.pdf')) }

    # ---------------------------------------------------------------------

    describe 'analysers' do
      it 'adds #pdf_properties' do
        pdf.must_respond_to :pdf_properties
      end

      it 'allows an options parameter on #pdf_properties' do
        pdf.pdf_properties.must_be_kind_of Hash
      end

      it 'adds #page_count' do
        pdf.must_respond_to :page_count
      end

      it 'adds #page_numbers' do
        pdf.must_respond_to :page_numbers
      end

      it 'adds #page_dimensions' do
        pdf.must_respond_to :page_dimensions
      end

      it 'adds #aspect_ratios' do
        pdf.must_respond_to :aspect_ratios
      end

      it 'adds #page_rotations' do
        pdf.must_respond_to :page_rotations
      end
    end

    # ---------------------------------------------------------------------

    describe 'processors' do
      it 'adds #append' do
        pdf.must_respond_to :append
      end
      it 'adds #page' do
        pdf.must_respond_to :page
      end
      it 'adds #page_thumb' do
        pdf.must_respond_to :page_thumb
      end
      it 'adds #remove_password' do
        pdf.must_respond_to :remove_password
      end
      it 'adds #rotate' do
        pdf.must_respond_to :rotate
      end
      it 'adds #stamp' do
        pdf.must_respond_to :stamp
      end
      it 'adds #subset_fonts' do
        pdf.must_respond_to :subset_fonts
      end
    end

    describe 'DragonflyLibvips proxy' do
      describe 'page_thumb' do
        it 'encodes the image to the correct format' do
          pdf.page_thumb!(1, '600x')
          `file --mime-type #{pdf.path}`.must_include 'image/jpeg'
        end
      end
    end
  end
end
