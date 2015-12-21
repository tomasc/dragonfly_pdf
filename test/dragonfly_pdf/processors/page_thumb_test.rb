require 'test_helper'
require 'pdf-reader'

module DragonflyPdf
  module Processors
    describe PageThumb do
      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::PageThumb.new }
      let(:single_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }

      # =====================================================================

      it 'returns PNG by default' do
        processor.call(single_pages, 1, density: 72)
        get_mime_type(single_pages.path).must_include "image/png"
      end

      it 'raises PageNotFound error' do
        proc { processor.call(single_pages, 0) }.must_raise DragonflyPdf::PageNotFound
        proc { processor.call(single_pages, 11) }.must_raise DragonflyPdf::PageNotFound
      end

      it 'renders page' do
        processor.call(single_pages, 1, density: 72)       
      end

      # ---------------------------------------------------------------------

      def get_mime_type file_path
        `file --mime-type #{file_path}`.gsub(/\n/, "")
      end
    end
  end
end
