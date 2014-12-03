require 'test_helper'

module DragonflyPdf
  describe Plugin do

    let(:app) { test_app.configure_with(:pdf) }
    let(:pdf) { app.fetch_file(SAMPLES_DIR.join('sample_pages.pdf')) }

    # ---------------------------------------------------------------------

    # describe 'analysers' do
    #   it 'adds #svg_properties' do
    #     svg.must_respond_to :svg_properties
    #   end

    #   it 'adds #width' do
    #     svg.must_respond_to :width
    #   end

    #   it 'adds #height' do
    #     svg.must_respond_to :height
    #   end

    #   it 'adds #aspect_ratio' do
    #     svg.must_respond_to :aspect_ratio
    #   end

    #   it 'adds #id' do
    #     svg.must_respond_to :id
    #   end
    # end

    # ---------------------------------------------------------------------

    # describe 'processors' do
    #   it 'adds #extend_ids' do
    #     svg.must_respond_to :extend_ids
    #   end

    #   it 'adds #remove_namespaces' do
    #     svg.must_respond_to :remove_namespaces
    #   end

    #   it 'adds #set_dimensions' do
    #     svg.must_respond_to :set_dimensions
    #   end

    #   it 'adds #set_namespace' do
    #     svg.must_respond_to :set_namespace
    #   end

    #   it 'adds #set_preserve_aspect_ratio' do
    #     svg.must_respond_to :set_preserve_aspect_ratio
    #   end

    #   it 'adds #set_view_box' do
    #     svg.must_respond_to :set_view_box
    #   end
    # end

  end
end