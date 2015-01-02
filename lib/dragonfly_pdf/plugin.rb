require 'dragonfly_pdf/analysers/pdf_properties'
require 'dragonfly_pdf/processors/page_thumb'

module DragonflyPdf
  class Plugin

    def call app, opts={}
      app.add_analyser :pdf_properties, DragonflyPdf::Analysers::PdfProperties.new

      app.add_analyser :width do |content|
        content.analyse(:pdf_properties)[:width]
      end
      
      app.add_analyser :height do |content|
        content.analyse(:pdf_properties)[:height]
      end
      
      app.add_analyser :aspect_ratio do |content|
        attrs = content.analyse(:pdf_properties)
        attrs[:width].to_f / attrs[:height].to_f
      end
      
      app.add_analyser :portrait do |content|
        attrs = content.analyse(:pdf_properties)
        attrs[:width] <= attrs[:height]
      end
      app.define(:portrait?) { portrait }
      
      app.add_analyser :landscape do |content|
        !content.analyse(:portrait)
      end
      app.define(:landscape?) { landscape }

      # ---------------------------------------------------------------------
      
      app.add_processor :page_thumb, DragonflyPdf::Processors::PageThumb.new
    end

  end
end

Dragonfly::App.register_plugin(:pdf) { DragonflyPdf::Plugin.new }