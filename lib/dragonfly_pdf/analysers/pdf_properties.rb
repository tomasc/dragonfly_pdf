module DragonflyPdf
  module Analysers
    class PdfProperties
      def call(content, _options = {})
        return {} unless SUPPORTED_FORMATS.include?(content.ext)

        data = `pdftk #{content.path} dump_data`

        page_count = data.scan(/NumberOfPages: (\d+)/).flatten.first.to_i
        page_numbers = data.scan(/PageMediaNumber: (\d+)/).flatten.map(&:to_i)
        page_dimensions = data.scan(/PageMediaDimensions:\s*(\d+\.?\d+)\s*(\d+\.?\d+)/).map do |width_height|
          width_height.map(&:to_f).map { |dim| pt2mm(dim) }
        end
        page_rotations = data.scan(/PageMediaRotation: (\d+)/).flatten.map(&:to_f)
        aspect_ratios = page_dimensions.inject([]) { |res, page| res << (page.first / page.last) }

        {
          'format' => content.ext.try(:downcase),
          'aspect_ratios' => aspect_ratios,
          'page_count' => page_count,
          'page_dimensions' => page_dimensions,
          'page_numbers' => page_numbers,
          'page_rotations' => page_rotations
        }
      end

      private

      def pt2mm(pt)
        (pt / 72.0) * 25.4
      end
    end
  end
end
