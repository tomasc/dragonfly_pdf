require 'test_helper'

describe DragonflyPdf::Processors::RemovePassword do
  let(:app) { test_app.configure_with(:pdf) }
  let(:content) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample_pages_with_password.pdf')) }
  let(:processor) { DragonflyPdf::Processors::RemovePassword.new }

  before { processor.call(content, 1) }

  it { `pdftk #{content.path} dump_data`.wont_include 'OWNER PASSWORD REQUIRED' }
end
