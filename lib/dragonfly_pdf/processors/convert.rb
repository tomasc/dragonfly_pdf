require 'dragonfly_libvips/dimensions'
require 'vips'

module DragonflyPdf
  module Processors
    class Convert
      DPI = 300

      def call(content, page, geometry, options = {})
        options = options.deep_symbolize_keys

        input_options = options.fetch(:input_options, {})
        input_options[:access] = input_options.fetch(:access, 'sequential')
        input_options[:dpi] = input_options.fetch(:dpi, DPI)

        img = ::Vips::Image.new_from_file(content.path, input_options)

        dimensions = case geometry
                     when DragonflyLibvips::Processors::Thumb::RESIZE_GEOMETRY then DragonflyLibvips::Dimensions.call(geometry, img.width, img.height)
                     else raise ArgumentError, "Didn't recognise the geometry string: #{geometry}"
        end

        width = dimensions.width.ceil

        content.shell_update(ext: :png) do |old_path, new_path|
          "#{convert_command} -o #{new_path} -F png -O width=#{width},colorspace=rgb #{old_path} #{page}"
        end

        # MuPDF appends 1 at the end of the filename, we need to rename it back
        `mv #{content.path.sub('.png', '1.png')} #{content.path}`

        content.ext = :png
      end

      def update_url(url_attributes, _, options = {})
        url_attributes.ext = :png
      end

      private

      def convert_command
        'mutool convert'
      end
    end
  end
end
