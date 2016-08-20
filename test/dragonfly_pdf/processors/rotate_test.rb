require 'test_helper'

describe DragonflyPdf::Processors::Rotate do
  let(:app) { test_app.configure_with(:pdf) }
  let(:processor) { DragonflyPdf::Processors::Rotate.new }
  let(:sample_1) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }

  describe 'arg is String|Symbol' do
    it 'rotates all pages' do
      processor.call(sample_1, :left)
      sample_1.analyse(:page_rotations).must_equal [270, 270, 270, 270, 270, 270, 270, 270, 270, 270]
    end
  end

  describe 'arg is Hash' do
    it 'rotates only defined pages' do
      processor.call(sample_1, 1 => :left, 3 => :right)
      sample_1.analyse(:page_rotations).must_equal [270, 0.0, 90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    end
  end
end
