require 'test_helper'

module DragonflyPdf
  module Processors
    describe Append do
      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::Append.new }
      let(:sample_1) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
      let(:sample_2) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages_with_bleed.pdf')) }

      # =====================================================================

      it 'returns PDF by default' do
        processor.call(sample_1, [sample_2])
        get_mime_type(sample_1.path).must_include 'application/pdf'
      end

      it 'has total number of pages' do
        processor.call(sample_1, [sample_2])
        pdf = PDF::Reader.new(sample_1.path)
        pdf.pages.count.must_equal 11
      end

      # ---------------------------------------------------------------------

      def get_mime_type(file_path)
        `file --mime-type #{file_path}`.gsub(/\n/, '')
      end
    end
  end
end
