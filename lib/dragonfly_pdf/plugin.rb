require 'dragonfly_pdf/analysers/pdf_properties'
require 'dragonfly_pdf/processors/append'
require 'dragonfly_pdf/processors/page'
require 'dragonfly_pdf/processors/page_thumb'
require 'dragonfly_pdf/processors/rotate'
require 'dragonfly_pdf/processors/stamp'
require 'dragonfly_pdf/processors/subset_fonts'

module DragonflyPdf
  class Plugin
    def call(app, _opts = {})
      app.add_analyser :pdf_properties, DragonflyPdf::Analysers::PdfProperties.new

      app.add_analyser :page_count do |content|
        content.analyse(:pdf_properties)[:page_count]
      end

      app.add_analyser :page_numbers do |content|
        content.analyse(:pdf_properties)[:page_numbers]
      end

      app.add_analyser :page_dimensions do |content|
        content.analyse(:pdf_properties)[:page_dimensions]
      end

      app.add_analyser :widths do |content|
        content.analyse(:pdf_properties)[:widths]
      end

      app.add_analyser :heights do |content|
        content.analyse(:pdf_properties)[:heights]
      end

      app.add_analyser :aspect_ratios do |content|
        attrs = content.analyse(:pdf_properties)[:aspect_ratios]
      end

      # ---------------------------------------------------------------------

      app.add_processor :append, DragonflyPdf::Processors::Append.new
      app.add_processor :page, DragonflyPdf::Processors::Page.new
      app.add_processor :page_thumb, DragonflyPdf::Processors::PageThumb.new
      app.add_processor :rotate, DragonflyPdf::Processors::Rotate.new
      app.add_processor :stamp, DragonflyPdf::Processors::Stamp.new
      app.add_processor :subset_fonts, DragonflyPdf::Processors::SubsetFonts.new
    end
  end
end

Dragonfly::App.register_plugin(:pdf) { DragonflyPdf::Plugin.new }
