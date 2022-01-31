require 'test_helper'

module DragonflyPdf
  describe Plugin do
    let(:app) { test_app.configure_with(:pdf) }
    let(:content) { app.fetch_file(SAMPLES_DIR.join('sample_pages.pdf')) }

    describe 'analysers' do
      it { _(content).must_respond_to :pdf_properties }
      it { _(content.pdf_properties).must_be_kind_of Hash }
      it { _(content).must_respond_to :page_count }
      it { _(content).must_respond_to :page_numbers }
      it { _(content).must_respond_to :page_dimensions }
      it { _(content).must_respond_to :aspect_ratios }
      it { _(content).must_respond_to :page_rotations }
    end

    describe 'processors' do
      it { _(content).must_respond_to :append }
      it { _(content).must_respond_to :convert }
      it { _(content).must_respond_to :encode }
      it { _(content).must_respond_to :page }
      it { _(content).must_respond_to :page_thumb }
      it { _(content).must_respond_to :remove_password }
      it { _(content).must_respond_to :rotate }
      it { _(content).must_respond_to :stamp }
      it { _(content).must_respond_to :subset_fonts }
    end
  end
end
