require 'test_helper'
require 'pdf-reader'

module DragonflyPdf
  module Processors
    describe Page do
      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::Page.new }
      let(:sample_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }

      # =====================================================================

      it 'returns PDF by default' do
        processor.call(sample_pages, 1)
        get_mime_type(sample_pages.path).must_include 'application/pdf'
      end

      it 'raises PageNotFound error' do
        proc { processor.call(sample_pages, 0) }.must_raise DragonflyPdf::PageNotFound
        proc { processor.call(sample_pages, 11) }.must_raise DragonflyPdf::PageNotFound
      end

      describe 'single pages' do
        it 'renders page' do
          processor.call(sample_pages, 1)
          pdf = PDF::Reader.new(sample_pages.path)
          pdf.pages.count.must_equal 1
          pdf.pages.first.text.must_equal '1'
        end
      end

      # ---------------------------------------------------------------------

      def get_mime_type(file_path)
        `file --mime-type #{file_path}`.gsub(/\n/, '')
      end
    end
  end
end
