require 'pdf-reader'

module DragonflyPdf
  module Analysers
    class PdfProperties

      def call content, spreads=false
        pdf = PDF::Reader.new(content.file)
        {
          page_count: page_count(pdf, spreads),
          page_numbers: page_numbers(pdf, spreads),
          widths: widths(pdf),
          heights: heights(pdf),
          aspect_ratios: aspect_ratios(pdf),
          info: pdf.info
        }
      end

      private # =============================================================

      def pt2mm pt
        (pt / 72.0) * 25.4
      end

      def widths pdf
        pdf.pages.map do |page|
          media_box = page.attributes[:MediaBox]
          pt2mm(media_box[2] - media_box[0]).round(2)
        end
      end

      def heights pdf
        pdf.pages.map do |page|
          media_box = page.attributes[:MediaBox]
          pt2mm(media_box[3] - media_box[1]).round(2)
        end
      end

      def aspect_ratios pdf
        widths(pdf).zip(heights(pdf)).map do |width, height|
          (width / height).round(2)
        end
      end

      def page_numbers pdf, spreads
        return pdf.pages.collect { |p| p.number } unless spreads

        page_widths = widths(pdf)
        single_page_width = page_widths.uniq.count == 1 ? -9999999 : widths(pdf).min

        i = 1
        res = []
        spread = []

        page_widths.each do |page_width|
          if page_width > single_page_width
            spread << i
            i = i+1
            spread << i
          else
            spread << i
          end
          res << spread
          spread = []
          i = i+1
        end

        res

      end

      def page_count pdf, spreads
        return pdf.page_count unless spreads

        page_widths = widths(pdf)

        return page_widths.count*2 unless page_widths.uniq.count > 1

        spread_pages = page_widths - [page_widths.min]
        single_pages = page_widths - [page_widths.max]

        single_pages.count + spread_pages.count*2
      end

    end
  end
end
