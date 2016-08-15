module DragonflyPdf
  module Processors
    describe SubsetFonts do
      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::SubsetFonts.new }
      let(:sample_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }

      # =====================================================================

      it 'returns PDF by default' do
        processor.call(sample_pages, 1)
        get_mime_type(sample_pages.path).must_include 'application/pdf'
      end

      private # =============================================================

      def get_mime_type(file_path)
        `file --mime-type #{file_path}`.delete("\n")
      end
    end
  end
end
