module DragonflyPdf
  module Analysers
    class PdfProperties
      def call(content, options = {})
        box_type = options.fetch :box_type, 'TrimBox'
        box_data = content.data.scan(/(MediaBox|CropBox|BleedBox|TrimBox)\s?\[([\d\.]+?)\s([\d\.]+?)\s([\d\.]+?)\s([\d\.]+?)\]/)
        # drop last value, since that comes from data about all pages
        media_box = box_data.select { |d| d.first == 'MediaBox' }[0..-2]
        desired_box = box_data.select { |d| d.first == box_type }

        page_dimensions = (desired_box.length > 0 ? desired_box : media_box).map do |dim|
          i = dim[1..-1].map(&:to_f).map{ |d| pt2mm(d) }
          [ i[2]-i[0], i[3]-i[1] ]
        end

        page_count = page_dimensions.count
        aspect_ratios = page_dimensions.inject([]) { |res, page| res << (page.first / page.last) }
        page_numbers = (1..page_count).to_a

        {
          aspect_ratios: aspect_ratios,
          page_count: page_count,
          page_dimensions: page_dimensions,
          page_numbers: page_numbers
        }
      end

      private # =============================================================

      def pt2mm(pt)
        (pt / 72.0) * 25.4
      end
    end
  end
end
