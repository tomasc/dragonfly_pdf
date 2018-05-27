require 'test_helper'

module DragonflyPdf
  describe Plugin do
    let(:app) { test_app.configure_with(:pdf) }
    let(:content) { app.fetch_file(SAMPLES_DIR.join('sample_pages.pdf')) }

    describe 'analysers' do
      it { content.must_respond_to :pdf_properties }
      it { content.pdf_properties.must_be_kind_of Hash }
      it { content.must_respond_to :page_count }
      it { content.must_respond_to :page_numbers }
      it { content.must_respond_to :page_dimensions }
      it { content.must_respond_to :aspect_ratios }
      it { content.must_respond_to :page_rotations }
    end

    describe 'processors' do
      it { content.must_respond_to :append }
      it { content.must_respond_to :convert }
      it { content.must_respond_to :encode }
      it { content.must_respond_to :page }
      it { content.must_respond_to :page_thumb }
      it { content.must_respond_to :remove_password }
      it { content.must_respond_to :rotate }
      it { content.must_respond_to :stamp }
      it { content.must_respond_to :subset_fonts }
    end
  end
end
