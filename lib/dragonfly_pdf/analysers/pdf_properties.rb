module DragonflyPdf
  module Analysers
    class PdfProperties
      def call(content, options = {})
        box_type = options.fetch :box_type, 'TrimBox'

        box_data = []
        rotate_data = []
        IO.foreach(content.path, "\n\n", encoding: 'ISO-8859-1') do |item|
          box_data += item.scan(/(MediaBox|CropBox|BleedBox|TrimBox)\s?\[([\d\.]+?)\s([\d\.]+?)\s([\d\.]+?)\s([\d\.]+?)\]/)
          rotate_data += item.scan(/\/Rotate\s(\d+?)\s/)
        end

        media_box = box_data.select { |d| d.first =~ /mediabox/i }
        desired_box = box_data.select { |d| d.first =~ /#{box_type}/i }

        # drop last value, since that comes from data about all pages
        media_box = media_box[0..-2] if media_box.length > 1

        page_dimensions = (!desired_box.empty? ? desired_box : media_box).map do |dim|
          i = dim[1..-1].map(&:to_f).map { |d| pt2mm(d) }
          [i[2] - i[0], i[3] - i[1]]
        end

        page_count = page_dimensions.count
        aspect_ratios = page_dimensions.inject([]) { |res, page| res << (page.first / page.last) }
        page_numbers = (1..page_count).to_a
        page_rotations = rotate_data.flatten.map(&:to_f)

        {
          aspect_ratios: aspect_ratios,
          page_count: page_count,
          page_dimensions: page_dimensions,
          page_numbers: page_numbers,
          page_rotations: page_rotations
        }
      end

      private # =============================================================

      def pt2mm(pt)
        (pt / 72.0) * 25.4
      end
    end
  end
end
