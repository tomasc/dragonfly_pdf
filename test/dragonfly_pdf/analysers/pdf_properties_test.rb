require 'test_helper'

module DragonflyPdf
  module Analysers
    describe PdfProperties do

      let(:app) { test_app.configure_with(:pdf) }
      let(:analyser) { DragonflyPdf::Analysers::PdfProperties.new }

      let(:single_pages) { app.fetch_file(SAMPLES_DIR.join('sample_pages.pdf')) }
      let(:spreads) { app.fetch_file(SAMPLES_DIR.join('sample_spreads.pdf')) }

      describe 'call' do
        let(:pdf_properties) { analyser.call(single_pages) }

        it 'returns Hash' do
          pdf_properties.must_be_kind_of Hash
        end
      end

      describe '#page_numbers' do
        it 'returns one-dimensional array' do
          analyser.call(single_pages)[:page_numbers].must_equal [1,2,3,4,5,6,7,8,9,10]
        end
      end

      describe '#page_count' do  
        it 'returns correct page count' do
          analyser.call(single_pages)[:page_count].must_equal 10
        end
      end

      describe '#widths' do
        it 'returns widths' do
          analyser.call(single_pages)[:widths].must_equal [210.0, 210.0, 210.0, 210.0, 210.0, 210.0, 210.0, 210.0, 210.0, 210.0]
        end
      end

      describe '#heights' do
        it 'returns heights' do
          analyser.call(single_pages)[:heights].must_equal [297.0, 297.0, 297.0, 297.0, 297.0, 297.0, 297.0, 297.0, 297.0, 297.0]
        end
      end

      describe '#aspect_ratios' do
        it 'returns aspect ratios' do
          analyser.call(single_pages)[:aspect_ratios].map{ |i| i.round(2) }.must_equal [0.71, 0.71, 0.71, 0.71, 0.71, 0.71, 0.71, 0.71, 0.71, 0.71]
        end
      end
    end
  end
end
