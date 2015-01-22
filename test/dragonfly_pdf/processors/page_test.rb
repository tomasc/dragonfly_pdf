require 'test_helper'
require 'pdf-reader'

module DragonflyPdf
  module Processors
    describe Page do

      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::Page.new }

      let(:single_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
      let(:spreads) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_spreads.pdf')) }
      let(:spreads_back) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_spreads_back.pdf')) }
      let(:spreads_cover) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_spreads_cover.pdf')) }
      let(:spreads_cover_back) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_spreads_cover_back.pdf')) }

      before do
        spreads.meta['spreads'] = true
        spreads_cover.meta['spreads'] = true
        spreads_back.meta['spreads'] = true
        spreads_cover_back.meta['spreads'] = true
      end

      # =====================================================================

      it 'returns PDF by default' do
        processor.call(single_pages, 1)
        get_mime_type(single_pages.path).must_include "application/pdf"
      end

      it 'raises PageNotFound error' do
        proc { processor.call(single_pages, 0) }.must_raise DragonflyPdf::PageNotFound
        proc { processor.call(single_pages, 11) }.must_raise DragonflyPdf::PageNotFound
      end

      # ---------------------------------------------------------------------

      describe 'single pages' do
        it 'renders page' do
          processor.call(single_pages, 1)
          pdf = PDF::Reader.new(single_pages.path)
          pdf.pages.count.must_equal 1
          pdf.pages.first.text.must_equal '1'
        end
      end

      describe 'spreads' do
        it 'recalculates the page number correctly' do
          processor.call(spreads, 8, spreads: true)
          pdf = PDF::Reader.new(spreads.path)
          pdf.pages.count.must_equal 1
          pdf.pages.first.text.must_include '8'
        end
      end

      describe 'spreads_back' do
        it 'recalculates the page number correctly' do
          processor.call(spreads_back, 9, spreads: true)
          pdf = PDF::Reader.new(spreads_back.path)
          pdf.pages.count.must_equal 1
          pdf.pages.first.text.must_include '9'
        end
      end

      describe 'spreads_cover' do
        it 'recalculates the page number correctly' do
          processor.call(spreads_cover, 9, spreads: true)
          pdf = PDF::Reader.new(spreads_cover.path)
          pdf.pages.count.must_equal 1
          pdf.pages.first.text.must_include '9'
        end
      end

      describe 'spreads_cover_back' do
        it 'recalculates the page number correctly' do
          processor.call(spreads_cover_back, 10, spreads: true)
          pdf = PDF::Reader.new(spreads_cover_back.path)
          pdf.pages.count.must_equal 1
          pdf.pages.first.text.must_include '10'
        end
      end

      # ---------------------------------------------------------------------

      def get_mime_type file_path
        `file --mime-type #{file_path}`.gsub(/\n/, "")
      end

    end
  end
end
