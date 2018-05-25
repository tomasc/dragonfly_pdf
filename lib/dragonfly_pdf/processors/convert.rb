require 'dragonfly_libvips/dimensions'
require 'vips'

module DragonflyPdf
  module Processors
    class Convert
      DPI = 600

      def call(content, page, geometry=nil, options = {})
        raise UnsupportedFormat unless SUPPORTED_FORMATS.include?(content.ext)

        options = options.deep_symbolize_keys
        format = options.fetch(:format, :png)

        case format.to_sym
        when :pdf
          pdf_options = options.fetch(:pdf_options, "compress,compress-fonts,compress-images,linearize,sanitize,garbage=deduplicate")

          content.shell_update(ext: format) do |old_path, new_path|
            "#{convert_command} -o #{new_path} -F #{format} -O #{pdf_options} #{old_path} #{page}"
          end

        when :svg
          text = options.fetch(:text, :path)

          content.shell_update(ext: format) do |old_path, new_path|
            "#{convert_command} -o #{new_path} -F #{format} -O text=#{text} #{old_path} #{page}"
          end

          # MuPDF appends 1 at the end of the filename, we need to rename it back
          `mv #{content.path.sub(".#{format}", "1.#{format}")} #{content.path}`

        else
          input_options = options.fetch(:input_options, {})
          input_options[:access] = input_options.fetch(:access, 'sequential')
          input_options[:dpi] = input_options.fetch(:dpi, DPI)

          img = ::Vips::Image.new_from_file(content.path, input_options)

          dimensions = case geometry
          when DragonflyLibvips::Processors::Thumb::RESIZE_GEOMETRY then DragonflyLibvips::Dimensions.call(geometry, img.width, img.height)
          else raise ArgumentError, "Didn't recognise the geometry string: #{geometry}"
          end

          width = dimensions.width.ceil

          content.shell_update(ext: format) do |old_path, new_path|
            "#{convert_command} -o #{new_path} -F #{format} -O width=#{width},colorspace=rgb #{old_path} #{page}"
          end

          # MuPDF appends 1 at the end of the filename, we need to rename it back
          `mv #{content.path.sub(".#{format}", "1.#{format}")} #{content.path}`
        end

        content.meta['format'] = format.to_s
        content.ext = format
        content.meta['mime_type'] = nil # don't need it as we have ext now
      end

      def update_url(attrs, page, geometry=nil, options = {})
        options = options.deep_symbolize_keys
        format = options.fetch(:format, :png)

        attrs.ext = format.to_s
      end

      private

      def convert_command
        'mutool convert'
      end
    end
  end
end
