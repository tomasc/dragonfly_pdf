require 'test_helper'

describe DragonflyPdf::Processors::RemovePassword do
  let(:app) { test_app.configure_with(:pdf) }
  let(:processor) { DragonflyPdf::Processors::RemovePassword.new }
  let(:sample_pages) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages_with_password.pdf')) }

  it 'returns PDF by default' do
    processor.call(sample_pages, 1)
    `pdftk #{sample_pages.path} dump_data`.wont_include 'OWNER PASSWORD REQUIRED'
  end
end
