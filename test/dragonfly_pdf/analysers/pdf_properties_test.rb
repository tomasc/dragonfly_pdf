require 'test_helper'

module DragonflyPdf
  module Analysers
    describe PdfProperties do
      let(:app) { test_app.configure_with(:pdf) }
      let(:analyser) { DragonflyPdf::Analysers::PdfProperties.new }
      let(:sample_pages) { app.fetch_file(SAMPLES_DIR.join('sample_pages.pdf')) }
      let(:sample_pages_with_bleed) { app.fetch_file(SAMPLES_DIR.join('sample_pages_with_bleed.pdf')) }
      let(:sample_pages_rotated) { app.fetch_file(SAMPLES_DIR.join('sample_pages_rotated.pdf')) }

      # =====================================================================

      it 'returns Hash' do
        analyser.call(sample_pages).must_be_kind_of Hash
      end

      describe '#page_numbers' do
        it 'returns one-dimensional array' do
          analyser.call(sample_pages)[:page_numbers].must_equal (1..10).to_a
        end
      end

      describe '#page_count' do
        it 'returns correct page count' do
          analyser.call(sample_pages)[:page_count].must_equal 10
        end
      end

      describe '#page_dimensions' do
        it 'returns array of page dimensions' do
          analyser.call(sample_pages)[:page_dimensions].map { |p| p.map(&:round) }.must_equal [[210, 297]].cycle.take(10)
        end
      end

      describe '#aspect_ratios' do
        it 'returns aspect ratios' do
          analyser.call(sample_pages)[:aspect_ratios].map { |i| i.round(2) }.must_equal [0.71].cycle.take(10)
        end
      end

      describe '#page_rotations' do
        it 'returns correct page count' do
          analyser.call(sample_pages_rotated)[:page_rotations].must_equal [0.0, 90.0, 180.0, 270.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        end
      end
    end
  end
end
