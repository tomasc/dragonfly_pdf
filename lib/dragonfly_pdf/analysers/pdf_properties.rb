module DragonflyPdf
  module Analysers
    class PdfProperties
      NUMBER_OF_PAGES_REGEX = /NumberOfPages:\s*(\d+)/
      PAGE_MEDIA_NUMBER_REGEX = /PageMediaNumber:\s*(\d+)/
      PAGE_MEDIA_DIMENSIONS_REGEX = /PageMediaDimensions:\s*(\d+\,?\d+\.?\d+)\s*(\d+\,?\d+\.?\d+)/
      PAGE_MEDIA_ROTATIONS_REGEX = /PageMediaRotation:\s*(\d+)/

      def call(content, options = {})
        return {} unless content.ext
        return {} unless SUPPORTED_FORMATS.include?(content.ext.downcase)

        data = `pdftk "#{content.path}" dump_data`

        page_count = extract_page_count(data)
        page_numbers = extract_page_numbers(data)
        page_dimensions = extract_page_dimensions(data)
        page_rotations = extract_page_rotations(data)
        aspect_ratios = calculate_aspect_ratios(page_dimensions)

        {
          'aspect_ratios' => aspect_ratios,
          'format' => content.ext.downcase,
          'page_count' => page_count,
          'page_dimensions' => page_dimensions,
          'page_numbers' => page_numbers,
          'page_rotations' => page_rotations,
        }
      end

      private

      def extract_page_count(data)
        data.scan(NUMBER_OF_PAGES_REGEX).flatten.first.to_i
      end

      def extract_page_numbers(data)
        data.scan(PAGE_MEDIA_NUMBER_REGEX).flatten.map(&:to_i)
      end

      def extract_page_dimensions(data)
        data.scan(PAGE_MEDIA_DIMENSIONS_REGEX).map do |width, height|
          [pt_to_mm(width), pt_to_mm(height)]
        end
      end

      def pt_to_mm(length)
        pt = length.gsub(",", "").to_f
        (pt / 72.0) * 25.4
      end

      def extract_page_rotations(data)
        data.scan(PAGE_MEDIA_ROTATIONS_REGEX).flatten.map(&:to_f)
      end

      def calculate_aspect_ratios(page_dimensions)
        page_dimensions.map do |width, height|
          width / height.to_f
        end
      end
    end
  end
end
