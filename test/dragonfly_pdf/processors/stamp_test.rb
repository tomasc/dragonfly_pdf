require 'pdf-reader'
require 'test_helper'

module DragonflyPdf
  module Processors
    describe Stamp do
      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::Stamp.new }
      let(:sample_1) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
      let(:sample_stamp) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_stamp.pdf')) }
      let(:result) { PDF::Reader.new(sample_1.path) }

      # =====================================================================

      before do
        processor.call(sample_1, sample_stamp)
      end

      it 'returns PDF by default' do
        get_mime_type(sample_1.path).must_include 'application/pdf'
      end

      it 'has same number of pages' do
        result.pages.count.must_equal 10
      end

      it 'has the stamp' do
        result.pages.map(&:text).must_equal %w(STAMP).cycle(10).to_a
      end

      # ---------------------------------------------------------------------

      def get_mime_type(file_path)
        `file --mime-type #{file_path}`.delete("\n")
      end
    end
  end
end
