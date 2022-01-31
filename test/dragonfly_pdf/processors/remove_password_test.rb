require 'test_helper'

describe DragonflyPdf::Processors::RemovePassword do
  let(:app) { test_app.configure_with(:pdf) }
  let(:content) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages_with_password.pdf')) }
  let(:processor) { DragonflyPdf::Processors::RemovePassword.new }

  it 'removes password' do
    skip 'seems to longer be possible in newer versions of ghostscript'
    processor.call(content, 1)
    `pdftk #{content.path} dump_data`.wont_include 'OWNER PASSWORD REQUIRED'
  end

  it 'set the right extension on tempfile' do
    skip 'seems to longer be possible in newer versions of ghostscript'
    processor.call(content, 1)
    content.tempfile.path.must_match /\.pdf\z/
  end
end
