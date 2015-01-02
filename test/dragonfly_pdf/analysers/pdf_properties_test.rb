require 'test_helper'

module DragonflyPdf
  module Analysers
    describe PdfProperties do

      let(:app) { test_app.configure_with(:pdf) }
      let(:analyser) { DragonflyPdf::Analysers::PdfProperties.new }

      let(:single_pages) { app.fetch_file(SAMPLES_DIR.join('sample_pages.pdf')) }
      let(:spreads) { app.fetch_file(SAMPLES_DIR.join('sample_spreads.pdf')) }
      let(:spreads_back) { app.fetch_file(SAMPLES_DIR.join('sample_spreads_back.pdf')) }
      let(:spreads_cover) { app.fetch_file(SAMPLES_DIR.join('sample_spreads_cover.pdf')) }
      let(:spreads_cover_back) { app.fetch_file(SAMPLES_DIR.join('sample_spreads_cover_back.pdf')) }

      describe 'call' do
        let(:pdf_properties) { analyser.call(single_pages) }

        it 'returns Hash' do
          pdf_properties.must_be_kind_of Hash
        end
      end

      # ---------------------------------------------------------------------

      describe '#page_numbers' do
        describe 'for single page PDF' do
          it 'returns one-dimensional array' do
            analyser.call(single_pages)[:page_numbers].must_equal [1,2,3,4,5,6,7,8,9,10]
          end
        end

        describe 'for PDF with spreads' do
          it 'returns two-dimensional array' do
            analyser.call(spreads, spreads: true)[:page_numbers].must_equal [[1,2],[3,4],[5,6],[7,8]]
          end
        end

        describe 'for PDF with spreads and a cover' do
          it 'returns two-dimensional array' do
            analyser.call(spreads_cover, spreads: true)[:page_numbers].must_equal [[1],[2,3],[4,5],[6,7],[8,9]]
          end
        end

        describe 'for PDF with spreads and a back cover' do
          it 'returns two-dimensional array' do
            analyser.call(spreads_back, spreads: true)[:page_numbers].must_equal [[1,2],[3,4],[5,6],[7,8],[9]]
          end
        end

        describe 'for PDF with spreads and a front and a back cover' do
          it 'returns two-dimensional array' do
            analyser.call(spreads_cover_back, spreads: true)[:page_numbers].must_equal [[1],[2,3],[4,5],[6,7],[8,9],[10]]
          end
        end
      end

      # ---------------------------------------------------------------------

      describe '#page_count' do
        describe 'for single page PDF' do
          it 'returns correct page count' do
            analyser.call(single_pages)[:page_count].must_equal 10
          end
        end

        describe 'for PDF with spreads' do
          it 'returns correct page count' do
            analyser.call(spreads, spreads: true)[:page_count].must_equal 8
          end
        end

        describe 'for PDF with spreads and a cover' do
          it 'returns correct page count' do
            analyser.call(spreads_cover, spreads: true)[:page_count].must_equal 9
          end
        end

        describe 'for PDF with spreads and a back cover' do
          it 'returns correct page count' do
            analyser.call(spreads_back, spreads: true)[:page_count].must_equal 9
          end
        end

        describe 'for PDF with spreads and a front and a back cover' do
          it 'returns correct page count' do
            analyser.call(spreads_cover_back, spreads: true)[:page_count].must_equal 10
          end
        end
      end

      # ---------------------------------------------------------------------

      describe '#spread_count' do
        describe 'for single page PDF' do
          it 'returns correct page count' do
            analyser.call(single_pages)[:spread_count].must_equal 0
          end
        end

        describe 'for PDF with spreads' do
          it 'returns correct page count' do
            analyser.call(spreads, spreads: true)[:spread_count].must_equal 4
          end
        end

        describe 'for PDF with spreads and a cover' do
          it 'returns correct page count' do
            analyser.call(spreads_cover, spreads: true)[:spread_count].must_equal 5
          end
        end

        describe 'for PDF with spreads and a back cover' do
          it 'returns correct page count' do
            analyser.call(spreads_back, spreads: true)[:spread_count].must_equal 5
          end
        end

        describe 'for PDF with spreads and a front and a back cover' do
          it 'returns correct page count' do
            analyser.call(spreads_cover_back, spreads: true)[:spread_count].must_equal 6
          end
        end
      end

      # ---------------------------------------------------------------------

      describe '#widths' do
        describe 'for single page PDF' do
          it 'returns widths' do
            analyser.call(single_pages)[:widths].must_equal [210.0, 210.0, 210.0, 210.0, 210.0, 210.0, 210.0, 210.0, 210.0, 210.0]
          end
        end

        describe 'for PDF with spreads' do
          it 'returns widths' do
            analyser.call(spreads, spreads: true)[:widths].must_equal [[210.0, 210.0], [210.0, 210.0], [210.0, 210.0], [210.0, 210.0]]
          end
        end

        describe 'for PDF with spreads and a cover' do
          it 'returns correct widths' do
            analyser.call(spreads_cover, spreads: true)[:widths].must_equal [[210.0], [210.0, 210.0], [210.0, 210.0], [210.0, 210.0], [210.0, 210.0]]
          end
        end

        describe 'for PDF with spreads and a back cover' do
          it 'returns correct widths' do
            analyser.call(spreads_back, spreads: true)[:widths].must_equal [[210.0, 210.0], [210.0, 210.0], [210.0, 210.0], [210.0, 210.0], [210.0]]
          end
        end

        describe 'for PDF with spreads and a front and a back cover' do
          it 'returns correct widths' do
            analyser.call(spreads_cover_back, spreads: true)[:widths].must_equal [[210.0], [210.0, 210.0], [210.0, 210.0], [210.0, 210.0], [210.0, 210.0], [210.0]]
          end
        end
      end

      # ---------------------------------------------------------------------

      describe '#heights' do
        describe 'for single page PDF' do
          it 'returns heights' do
            analyser.call(single_pages)[:heights].must_equal [297.0, 297.0, 297.0, 297.0, 297.0, 297.0, 297.0, 297.0, 297.0, 297.0]
          end
        end

        describe 'for PDF with spreads' do
          it 'returns heights' do
            analyser.call(spreads, spreads: true)[:heights].must_equal [[297.0, 297.0], [297.0, 297.0], [297.0, 297.0], [297.0, 297.0]]
          end
        end

        describe 'for PDF with spreads and a cover' do
          it 'returns correct heights' do
            analyser.call(spreads_cover, spreads: true)[:heights].must_equal [[297.0], [297.0, 297.0], [297.0, 297.0], [297.0, 297.0], [297.0, 297.0]]
          end
        end

        describe 'for PDF with spreads and a back cover' do
          it 'returns correct heights' do
            analyser.call(spreads_back, spreads: true)[:heights].must_equal [[297.0, 297.0], [297.0, 297.0], [297.0, 297.0], [297.0, 297.0], [297.0]]
          end
        end

        describe 'for PDF with spreads and a front and a back cover' do
          it 'returns correct heights' do
            analyser.call(spreads_cover_back, spreads: true)[:heights].must_equal [[297.0], [297.0, 297.0], [297.0, 297.0], [297.0, 297.0], [297.0, 297.0], [297.0]]
          end
        end
      end

      # ---------------------------------------------------------------------

      describe '#aspect_ratios' do
        describe 'for single page PDF' do
          it 'returns aspect ratios' do
            analyser.call(single_pages)[:aspect_ratios].map{ |i| i.round(2) }.must_equal [0.71, 0.71, 0.71, 0.71, 0.71, 0.71, 0.71, 0.71, 0.71, 0.71]
          end
        end

        describe 'for PDF with spreads' do
          it 'returns aspect ratios' do
            analyser.call(spreads, spreads: true)[:aspect_ratios].map{ |i| i.is_a?(Array) ? i.map{ |j| j.round(2) } : i.round(2) }.must_equal [[0.71, 0.71], [0.71, 0.71], [0.71, 0.71], [0.71, 0.71]]
          end
        end

        describe 'for PDF with spreads and a cover' do
          it 'returns correct aspect ratios' do
            analyser.call(spreads_cover, spreads: true)[:aspect_ratios].map{ |i| i.is_a?(Array) ? i.map{ |j| j.round(2) } : i.round(2) }.must_equal [[0.71], [0.71, 0.71], [0.71, 0.71], [0.71, 0.71], [0.71, 0.71]]
          end
        end

        describe 'for PDF with spreads and a back cover' do
          it 'returns correct aspect ratios' do
            analyser.call(spreads_back, spreads: true)[:aspect_ratios].map{ |i| i.is_a?(Array) ? i.map{ |j| j.round(2) } : i.round(2) }.must_equal [[0.71, 0.71], [0.71, 0.71], [0.71, 0.71], [0.71, 0.71], [0.71]]
          end
        end

        describe 'for PDF with spreads and a front and a back cover' do
          it 'returns correct aspect ratios' do
            analyser.call(spreads_cover_back, spreads: true)[:aspect_ratios].map{ |i| i.is_a?(Array) ? i.map{ |j| j.round(2) } : i.round(2) }.must_equal [[0.71], [0.71, 0.71], [0.71, 0.71], [0.71, 0.71], [0.71, 0.71], [0.71]]
          end
        end
      end

      # ---------------------------------------------------------------------

      describe '#info' do
        it 'returns Hash' do
          analyser.call(single_pages)[:info].must_be_kind_of Hash
        end
      end

    end
  end
end
