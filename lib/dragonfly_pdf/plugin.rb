require 'active_support/core_ext/hash'

require 'dragonfly_pdf/analysers/pdf_properties'

require 'dragonfly_pdf/processors/append'
require 'dragonfly_pdf/processors/convert'
require 'dragonfly_pdf/processors/page'
require 'dragonfly_pdf/processors/remove_password'
require 'dragonfly_pdf/processors/rotate'
require 'dragonfly_pdf/processors/stamp'
require 'dragonfly_pdf/processors/subset_fonts'

require 'dragonfly_libvips'
require 'dragonfly_libvips/analysers/image_properties'
require 'dragonfly_libvips/processors/thumb'

module DragonflyPdf
  class Plugin
    def call(app, _opts = {})
      app.add_analyser :image_properties, DragonflyLibvips::Analysers::ImageProperties.new
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

      app.add_analyser :page_rotations do |content|
        content.analyse(:pdf_properties)[:page_rotations]
      end

      app.add_analyser :aspect_ratios do |content|
        content.analyse(:pdf_properties)[:aspect_ratios]
      end

      # ---------------------------------------------------------------------

      app.add_processor :append, DragonflyPdf::Processors::Append.new
      app.add_processor :convert, DragonflyPdf::Processors::Convert.new
      app.add_processor :page, DragonflyPdf::Processors::Page.new
      app.add_processor :remove_password, DragonflyPdf::Processors::RemovePassword.new
      app.add_processor :rotate, DragonflyPdf::Processors::Rotate.new
      app.add_processor :stamp, DragonflyPdf::Processors::Stamp.new
      app.add_processor :subset_fonts, DragonflyPdf::Processors::SubsetFonts.new

      app.add_processor :thumb, DragonflyLibvips::Processors::Thumb.new

      app.add_processor :page_thumb do |content, page, geometry = nil, options = {}|
        options = options.deep_symbolize_keys
        options[:format] = options.fetch(:format, :jpg)

        convert_options = {}
        convert_options[:format] = case options[:format]
                                   when :pdf, :svg then options[:format]
                                   else :png
        end

        content.process!(:convert, page, geometry, convert_options)

        unless %i[pdf png svg].include?(options[:format].to_sym)
          content.process!(:thumb, geometry, options)
        end
      end
    end
  end
end

Dragonfly::App.register_plugin(:pdf) { DragonflyPdf::Plugin.new }
