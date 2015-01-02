require 'dragonfly_pdf/analysers/pdf_properties'

require 'dragonfly_pdf/processors/page'
require 'dragonfly_pdf/processors/page_thumb'

module DragonflyPdf
  class Plugin

    def call app, opts={}
      app.add_analyser :pdf_properties, DragonflyPdf::Analysers::PdfProperties.new

      app.add_analyser :page_count do |content|
        content.analyse(:pdf_properties)[:page_count]
      end

      app.add_analyser :spread_count do |content|
        content.analyse(:pdf_properties)[:spread_count]
      end

      app.add_analyser :page_numbers do |content|
        content.analyse(:pdf_properties)[:page_numbers]
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

      app.add_analyser :info do |content|
        attrs = content.analyse(:pdf_properties)[:info]
      end
      
      # ---------------------------------------------------------------------
      
      app.add_processor :page_thumb, DragonflyPdf::Processors::PageThumb.new
      app.add_processor :page, DragonflyPdf::Processors::Page.new
    end

  end
end

Dragonfly::App.register_plugin(:pdf) { DragonflyPdf::Plugin.new }