require 'pdf-reader'

module DragonflyPdf
  module Processors
    class PageThumb

      def call content, page_number=0, spreads=false, density=600, format=:tif, options={}
        if spreads
          # get dimensions of all pages
          # TODO: Use analyser?
          page_dimensions = raw_identify(temp_object, '-density 12 -format "%W," -define pdf:use-cropbox=true -define pdf:use-trimbox=true').split(",").reject(&:blank?).map(&:to_i)

          # make a map of these pages
          # index is page we are looking for, value is page in pdf
          page_map = []

          # go through all pages in pdf
          real_page = 0
        end
      end


      # def page_thumb temp_object, page_number=0, spreads=false, density=600, format=:tif, options={}

      #   if spreads
      #     # get dimensions of all pages
      #     list_of_page_dimensions = raw_identify(temp_object, '-density 12 -format "%W," -define pdf:use-cropbox=true -define pdf:use-trimbox=true').split(",").reject(&:blank?).map(&:to_i)

      #     # split into groups by width, and sort
      #     width_index = list_of_page_dimensions.uniq.sort

      #     # make a map of these pages
      #     # index is page we are looking for, value is page in pdf
      #     page_map = []

      #     # go through all pages in pdf
      #     real_page = 0

      #     # spreads only
      #     if width_index.count == 1

      #       list_of_page_dimensions.each_with_index do |page_width, pdf_page_index|
      #         page_map[real_page] = { pdf_page: pdf_page_index, side: 0 }
      #         real_page += 1
      #         page_map[real_page] = { pdf_page: pdf_page_index, side: 1 }
      #         real_page += 1
      #       end

      #       # combination of single pages & spreads
      #     else

      #       list_of_page_dimensions.each_with_index do |page_width, pdf_page_index|
      #         # single is 0, spread is 1
      #         page_type = width_index.index(page_width)
      #         # is single page, add it and go
      #         if page_type == 0
      #           page_map[real_page] = { pdf_page: pdf_page_index, side: nil }
      #           real_page += 1

      #         elsif page_type == 1
      #           page_map[real_page] = { pdf_page: pdf_page_index, side: 0 }
      #           real_page += 1
      #           page_map[real_page] = { pdf_page: pdf_page_index, side: 1 }
      #           real_page += 1

      #         end
      #       end

      #     end

      #     pdf_page_number = page_map[page_number][:pdf_page]

      #     if !page_map[page_number][:side].nil?
      #       # find out, whether we need left (0) or right (1) page
      #       side = page_map[page_number][:side]
      #       side_to_delete = (side == 0 ? 1 : 0)

      #       # crop with the page number we want to take from the real PDF, plus indicate side (left=0, right=1)
      #       # but only if we deal with spread
      #       pre_args = "-crop 50%x100% -delete #{side_to_delete}"
      #     else
      #       pre_args = nil
      #     end

      #     pdf_convert(temp_object, pre_args, nil, pdf_page_number, density)
      #   else
      #     pdf_convert(temp_object, nil, nil, page_number, density)
      #   end
      # end

      # private # =============================================================

      # def pdf_convert temp_object=nil, pre_args='', args='', page_number=0, density=600, format=:tif
      #   tempfile = new_tempfile(format)
      #   run "#{convert_command} -alpha deactivate -background white -colorspace sRGB -density #{density}x#{density} -define pdf:use-cropbox=true -define pdf:use-trimbox=true #{pre_args} #{quote(temp_object.path)}[#{page_number}] #{args} #{quote(tempfile.path)}"
      #   tempfile
      # end

    end
  end
end