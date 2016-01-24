require 'pdf-reader'
require 'test_helper'

module DragonflyPdf
  module Processors
    describe Rotate do
      let(:app) { test_app.configure_with(:pdf) }
      let(:processor) { DragonflyPdf::Processors::Rotate.new }
      let(:sample_1) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
      let(:result) { PDF::Reader.new(sample_1.path) }

      # =====================================================================

      it 'returns PDF by default' do
        processor.call(sample_1, :left)
        get_mime_type(sample_1.path).must_include 'application/pdf'
      end

      describe 'arg is String|Symbol' do
        it 'rotates all pages' do
          processor.call(sample_1, :left)
          result.pages.map { |p| p.attributes[:Rotate] }.must_equal [270, 270, 270, 270, 270, 270, 270, 270, 270, 270]
        end
      end

      describe 'arg is Hash' do
        it 'rotates only defined pages' do
          processor.call(sample_1, 1 => :left, 3 => :right)
          result.pages.map { |p| p.attributes[:Rotate] }.must_equal [270, nil, 90, nil, nil, nil, nil, nil, nil, nil]
        end
      end

      # ---------------------------------------------------------------------

      def get_mime_type(file_path)
        `file --mime-type #{file_path}`.gsub(/\n/, '')
      end
    end
  end
end
