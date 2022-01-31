require 'test_helper'

describe DragonflyPdf::Processors::Rotate do
  let(:app) { test_app.configure_with(:pdf) }
  let(:content) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:processor) { DragonflyPdf::Processors::Rotate.new }

  describe 'String|Symbol' do
    before { processor.call(content, :left) }
    it { _(content.analyse(:page_rotations)).must_equal [270, 270, 270, 270, 270, 270, 270, 270, 270, 270] }
  end

  describe 'arg is Hash' do
    before { processor.call(content, 1 => :left, 3 => :right) }
    it { _(content.analyse(:page_rotations)).must_equal [270, 0.0, 90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] }
  end

  describe 'tempfile has extension' do
    before { processor.call(content, :left) }
    it { _(content.tempfile.path).must_match /\.pdf\z/ }
  end
end
