require 'test_helper'

describe DragonflyPdf::Analysers::PdfProperties do
  let(:app) { test_app.configure_with(:pdf) }
  let(:analyser) { DragonflyPdf::Analysers::PdfProperties.new }
  let(:sample_pages) { app.fetch_file(SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:sample_pages_with_bleed) { app.fetch_file(SAMPLES_DIR.join('sample_pages_with_bleed.pdf')) }
  let(:sample_pages_rotated) { app.fetch_file(SAMPLES_DIR.join('sample_pages_rotated.pdf')) }
  let(:sample_wide) { app.fetch_file(SAMPLES_DIR.join('sample_wide.pdf')) }

  it { analyser.call(sample_pages).must_be_kind_of Hash }
  it { analyser.call(sample_pages)['page_numbers'].must_equal (1..10).to_a }
  it { analyser.call(sample_pages)['page_count'].must_equal 10 }
  it { analyser.call(sample_pages)['page_dimensions'].map { |p| p.map(&:round) }.must_equal [[210, 297]].cycle.take(10) }
  it { analyser.call(sample_pages)['aspect_ratios'].map { |i| i.round(2) }.must_equal [0.71].cycle.take(10) }
  it { analyser.call(sample_pages_rotated)['page_rotations'].must_equal [0.0, 90.0, 180.0, 270.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] }
  it { analyser.call(sample_wide)['page_dimensions'].map { |p| p.map(&:round) }.must_equal [[420, 297]] }
end
