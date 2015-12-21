require 'pdf-reader'

module DragonflyPdf
  module Analysers
    class PdfProperties

      def call(content)
        @content = content
        {
          aspect_ratios: aspect_ratios,
          heights: heights,
          page_count: page_count,
          page_dimensions: page_dimensions,
          page_numbers: page_numbers,
          widths: widths
        }
      end

      private # =============================================================

      def page_dimensions
        @page_dimensions ||= "#{identify_command} -format \"%[pdf:HiResBoundingBox]\" #{@content.path}".scan(/(\d+?)x(\d+?)\+\d\+\d/).map do |page|
          page = page.map(&:to_f) 
        end
      end

      def widths
        page_dimensions.inject([]) do |res, page|
          res << page[0]
        end
      end

      def heights
        page_dimensions.inject([]) do |res, page|
          res << page[1]
        end
      end

      def aspect_ratios
        page_dimensions.inject([]) do |res, page|
          res << page[1]/page[0]
        end
      end

      def page_numbers
        (1..page_count).to_a
      end

      def page_count
        page_dimensions.count
      end

      # =====================================================================

      def pt2mm pt
        (pt / 72.0) * 25.4
      end

      def identify_command
        "identify -density 12 -define pdf:use-cropbox=true -define pdf:use-trimbox=true"
      end
    end
  end
end
