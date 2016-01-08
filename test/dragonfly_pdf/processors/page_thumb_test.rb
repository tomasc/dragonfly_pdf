require 'test_helper'

module DragonflyPdf
  module Processors
    describe PageThumb do
      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::PageThumb.new }
      let(:sample_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }

      # =====================================================================

      it 'returns PNG by default' do
        processor.call(sample_pages, 1, density: 72)
        get_mime_type(sample_pages.path).must_include 'image/png'
      end

      it 'raises PageNotFound error' do
        skip 'calling the page properties slows evrything down'
        proc { processor.call(sample_pages, 0) }.must_raise DragonflyPdf::PageNotFound
        proc { processor.call(sample_pages, 11) }.must_raise DragonflyPdf::PageNotFound
      end

      it 'renders page' do
        processor.call(sample_pages, 1, density: 72)
      end

      # ---------------------------------------------------------------------

      def get_mime_type(file_path)
        `file --mime-type #{file_path}`.gsub(/\n/, '')
      end
    end
  end
end
