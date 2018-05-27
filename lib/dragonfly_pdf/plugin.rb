require 'dragonfly_pdf/analysers/pdf_properties'

require 'dragonfly_pdf/processors/append'
require 'dragonfly_pdf/processors/convert'
require 'dragonfly_pdf/processors/page_thumb'
require 'dragonfly_pdf/processors/page'
require 'dragonfly_pdf/processors/remove_password'
require 'dragonfly_pdf/processors/rotate'
require 'dragonfly_pdf/processors/stamp'
require 'dragonfly_pdf/processors/subset_fonts'

module DragonflyPdf
  class Plugin
    def call(app, _opts = {})
      app.add_analyser :pdf_properties, Analysers::PdfProperties.new

      %w[ page_count
          page_numbers
          page_dimensions
          page_rotations
          aspect_ratios
      ].each do |name|
        app.add_analyser(name) { |c| c.analyse(:pdf_properties)[name] }
      end

      app.add_processor :append, Processors::Append.new
      app.add_processor :convert, Processors::Convert.new
      app.add_processor :page, Processors::Page.new
      app.add_processor :remove_password, Processors::RemovePassword.new
      app.add_processor :rotate, Processors::Rotate.new
      app.add_processor :stamp, Processors::Stamp.new
      app.add_processor :subset_fonts, Processors::SubsetFonts.new
      app.add_processor :page_thumb, Processors::PageThumb.new

      app.define(:encode) { convert }
    end
  end
end

Dragonfly::App.register_plugin(:pdf) { DragonflyPdf::Plugin.new }
