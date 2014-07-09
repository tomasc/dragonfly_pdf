# pdf_processor.rb

module Dragonfly
  module Analysers

    # IMPORTANT: Requires +ImageMagick+

    class PdfAnalyser

      include Dragonfly::Configurable
      include Dragonfly::Shell
      include Dragonfly::ImageMagick::Utils

      # =====================================================================

      def aspect_ratio temp_object
        format, width, height, depth = raw_identify(temp_object, '-density 300 -define pdf:use-cropbox=true -define pdf:use-trimbox=true').scan(/([A-Z0-9]+) (\d+)x(\d+) .+ (\d+)-bit/)[0]
        width.to_f / height.to_f
      end

      def number_of_pages temp_object, split_spreads=false
        if split_spreads
          # get list of page widths
          list_of_page_dimensions = raw_identify(temp_object, '-density 12 -format "%W," -define pdf:use-cropbox=true -define pdf:use-trimbox=true').split(",").reject(&:blank?).map(&:to_i).sort
          # split into groups by width, and sort
          page_groups = list_of_page_dimensions.group_by{ |i| list_of_page_dimensions.uniq.index(i) }
          # if multiple widths, first group counts as one page, second as two pages
          if page_groups.count > 1
            res = page_groups[0].count + page_groups[1].count*2
          # otherwise we say these are spreads
          else
            res = page_groups[0].count*2
          end
          res
        else
          raw_identify(temp_object, '-density 12 -format "%n" -define pdf:use-cropbox=true -define pdf:use-trimbox=true').to_i
        end
      end



      # TODO: Remove?
      # def number_of_pages temp_object
      #   raw_identify(temp_object, '-density 12 -format "%n" -define pdf:use-cropbox=true').to_i
      # end



      # ---------------------------------------------------------------------



    end
  end
end