require 'dragonfly_libvips'
require 'vips'

module DragonflyPdf
  module Processors
    class Convert
      DPI = 600

      def call(content, page, geometry = nil, options = {})
        raise UnsupportedFormat unless SUPPORTED_FORMATS.include?(content.ext)

        options = options.each_with_object({}) { |(k, v), memo| memo[k.to_s] = v } # stringify keys
        format = options.fetch('format', 'png').to_s

        raise UnsupportedOutputFormat unless SUPPORTED_OUTPUT_FORMATS.include?(format)

        case format
        when 'pdf'
          pdf_options = options.fetch('pdf_options', 'compress,compress-fonts,compress-images,linearize,sanitize,garbage=deduplicate')

          content.shell_update(ext: format) do |old_path, new_path|
            "#{convert_command} -o #{new_path} -F #{format} -O #{pdf_options} #{old_path} #{page}"
          end

        when 'svg'
          text = options.fetch('text', 'path')

          content.shell_update(ext: format) do |old_path, new_path|
            "#{convert_command} -o #{new_path} -F #{format} -O text=#{text} #{old_path} #{page}"
          end

          # MuPDF appends 1 at the end of the filename, we need to rename it back
          `mv #{content.path.sub(".#{format}", "1.#{format}")} #{content.path}`

        else
          input_options = options.fetch('input_options', {})
          input_options['access'] = input_options.fetch('access', 'sequential')
          input_options['dpi'] = input_options.fetch('dpi', DPI)

          img = ::Vips::Image.new_from_file(content.path, input_options)

          dimensions = case geometry
                       when DragonflyLibvips::Processors::Thumb::RESIZE_GEOMETRY
                         DragonflyLibvips::Dimensions.call(geometry, img.width, img.height)
                       else
                         raise ArgumentError, "Didn't recognise the geometry string: #{geometry}"
                       end

          width = dimensions.width.ceil

          content.shell_update(ext: format) do |old_path, new_path|
            "#{convert_command} -o #{new_path} -F #{format} -O width=#{width},colorspace=rgb #{old_path} #{page}"
          end

          # MuPDF appends 1 at the end of the filename, we need to rename it back
          `mv #{content.path.sub(".#{format}", "1.#{format}")} #{content.path}`
        end

        content.meta['format'] = format
        content.ext = format
        content.meta['mime_type'] = nil # don't need it as we have ext now
      end

      def update_url(attrs, _page, _geometry = nil, options = {})
        options = options.each_with_object({}) { |(k, v), memo| memo[k.to_s] = v } # stringify keys
        format = options.fetch('format', 'png').to_s
        attrs.ext = format
      end

      private

      def convert_command
        'mutool convert'
      end
    end
  end
end
