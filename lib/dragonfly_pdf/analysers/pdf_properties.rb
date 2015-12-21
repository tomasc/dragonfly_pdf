require 'pdf-reader'

module DragonflyPdf
  module Analysers
    class PdfProperties
      def call(content, options = {})
        @content = content
        @use_cropbox = options.fetch :use_cropbox, true
        @use_trimbox = options.fetch :use_trimbox, true
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
        @page_dimensions ||= begin
          res = @content.shell_eval do |path|
            "#{identify_command} -format '%Wx%H,' #{path}"
          end
          res.to_s.split(/\s*,\s*/).compact.map do |page|
            page = page.split(/\s*x\s*/).map(&:to_f).map { |n| pt2mm(n) }
          end
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
          res << page[0] / page[1]
        end
      end

      def page_numbers
        (1..page_count).to_a
      end

      def page_count
        page_dimensions.count
      end

      # =====================================================================

      def pt2mm(pt)
        (pt / 72.0) * 25.4
      end

      def identify_command
        "identify -define pdf:use-cropbox=#{@use_cropbox} -define pdf:use-trimbox=#{@use_trimbox}"
      end
    end
  end
end
