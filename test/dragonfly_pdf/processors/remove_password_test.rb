require 'pdf-reader'
require 'test_helper'

module DragonflyPdf
  module Processors
    describe RemovePassword do
      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::RemovePassword.new }
      let(:sample_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages_with_password.pdf')) }
      let(:result) { PDF::Reader.new(sample_pages.path) }

      # =====================================================================

      it 'returns PDF by default' do
        processor.call(sample_pages, 1)
        get_mime_type(sample_pages.path).must_include 'application/pdf'
      end

      # ---------------------------------------------------------------------

      def get_mime_type(file_path)
        `file --mime-type #{file_path}`.gsub(/\n/, '')
      end
    end
  end
end
