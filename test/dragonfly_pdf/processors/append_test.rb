require 'test_helper'

describe DragonflyPdf::Processors::Append do
  let(:app) { test_app.configure_with(:pdf) }
  let(:processor) { DragonflyPdf::Processors::Append.new }
  let(:content_1) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages.pdf')) }
  let(:content_2) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages_with_bleed.pdf')) }

  before { processor.call(content_1, [content_2]) }

  it { content_1.analyse(:page_count).must_equal 11 }

  describe 'tempfile has extension' do
    it { content_1.tempfile.path.must_match /\.pdf\z/ }
  end
end
