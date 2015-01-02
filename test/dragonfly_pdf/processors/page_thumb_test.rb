require 'test_helper'

module DragonflyPdf
  module Processors
    describe PageThumb do

      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::PageThumb.new }

      let(:single_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
      let(:spreads) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_spreads.pdf')) }
      let(:spreads_back) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_spreads_back.pdf')) }
      let(:spreads_cover) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_spreads_cover.pdf')) }
      let(:spreads_cover_back) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_spreads_cover_back.pdf')) }

      it 'returns PNG by default' do
        processor.call(single_pages, 0, density: 72)
        get_mime_type(single_pages.path).must_include "image/png"
      end

      # ---------------------------------------------------------------------

      describe 'single pages' do
      end

      describe 'spreads' do
        it 'recalculates the page number correctly' do
          processor.call(spreads, 3, density: 72, spreads: true)
          skip
        end
      end

      # ---------------------------------------------------------------------
      
      def get_mime_type file_path
        `file --mime-type #{file_path}`.gsub(/\n/, "")
      end

    end
  end
end