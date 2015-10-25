require 'pdf-reader'

module DragonflyPdf
  module Analysers
    class PdfProperties

      def call content
        spreads = content.meta['spreads'] || false

        pdf = PDF::Reader.new(content.file)

        {
          aspect_ratios: aspect_ratios(pdf, spreads),
          heights: heights(pdf, spreads),
          page_count: page_count(pdf, spreads),
          page_numbers: page_numbers(pdf, spreads),
          spread_count: spread_count(pdf, spreads),
          widths: widths(pdf, spreads)
        }
      end

      private # =============================================================

      def widths pdf, spreads
        pdf_page_widths = pdf.pages.map do |page|
          media_box = page.attributes[:MediaBox]
          pt2mm(media_box[2] - media_box[0]).round(2)
        end

        return pdf_page_widths unless spreads

        res = []
        i = 0
        spread = []
        page_numbers(pdf, spreads).each do |s|
          if s.count == 1
            spread << pdf_page_widths[i]
          else
            spread << pdf_page_widths[i]/2
            spread << pdf_page_widths[i]/2
          end
          res << spread
          spread = []
          i = i+1
        end
        res
      end

      # ---------------------------------------------------------------------

      def heights pdf, spreads
        pdf_page_heights = pdf.pages.map do |page|
          media_box = page.attributes[:MediaBox]
          pt2mm(media_box[3] - media_box[1]).round(2)
        end

        return pdf_page_heights unless spreads

        res = []
        i = 0
        spread = []
        page_numbers(pdf, spreads).each do |s|
          if s.count == 1
            spread << pdf_page_heights[i]
          else
            spread << pdf_page_heights[i]
            spread << pdf_page_heights[i]
          end
          res << spread
          spread = []
          i = i+1
        end
        res
      end

      # ---------------------------------------------------------------------

      def aspect_ratios pdf, spreads
        pdf_aspect_ratios = widths(pdf, false).zip(heights(pdf, false)).map do |width, height|
          (width / height)
        end

        return pdf_aspect_ratios unless spreads

        res = []
        i = 0
        spread = []
        page_numbers(pdf, spreads).each do |s|
          if s.count == 1
            spread << pdf_aspect_ratios[i]
          else
            spread << pdf_aspect_ratios[i]/2
            spread << pdf_aspect_ratios[i]/2
          end
          res << spread
          spread = []
          i = i+1
        end
        res
      end

      # ---------------------------------------------------------------------

      def page_numbers pdf, spreads
        return pdf.pages.collect { |p| p.number } unless spreads

        page_widths = widths(pdf, false)
        single_page_width = page_widths.uniq.count == 1 ? -9999999 : widths(pdf, false).min

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

      # ---------------------------------------------------------------------

      def page_count pdf, spreads
        page_numbers(pdf, spreads).flatten.count
      end

      def spread_count pdf, spreads
        return 0 unless spreads
        page_numbers(pdf, spreads).count
      end

      # =====================================================================

      def pt2mm pt
        (pt / 72.0) * 25.4
      end

    end
  end
end
