require 'dragonfly_pdf/analysers/pdf_properties'
require 'dragonfly_pdf/processors/page_thumb'

module DragonflyPdf
  class Plugin

    def call app, opts={}
      app.add_analyser :pdf_properties, DragonflyPdf::Analysers::PdfProperties.new
      # app.add_analyser :width do |content|
      #   content.analyse(:svg_properties)[:width]
      # end
      # app.add_analyser :height do |content|
      #   content.analyse(:svg_properties)[:height]
      # end
      # app.add_analyser :aspect_ratio do |content|
      #   attrs = content.analyse(:svg_properties)
      #   attrs[:width].to_f / attrs[:height].to_f
      # end
      # app.add_analyser :portrait do |content|
      #   attrs = content.analyse(:svg_properties)
      #   attrs[:width] <= attrs[:height]
      # end
      # app.add_analyser :landscape do |content|
      #   !content.analyse(:portrait)
      # end
      # app.add_analyser :id do |content|
      #   content.analyse(:svg_properties)[:id]
      # end

      # # Aliases
      # app.define(:portrait?) { portrait }
      # app.define(:landscape?) { landscape }

      app.add_processor :page_thumb, DragonflyPdf::Processors::PageThumb.new
    end

  end
end

Dragonfly::App.register_plugin(:pdf) { DragonflyPdf::Plugin.new }