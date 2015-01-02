require 'pdf-reader'
require_relative '../analysers/pdf_properties'

module DragonflyPdf
  module Processors
    class Page

      class UnsupportedFormat < RuntimeError; end

      def call content, page_number=0, opts={}
        spreads = opts.fetch(:spreads, false)
        pdf_page_number = page_number
        crop_args = ''

        pdf_properties = DragonflyPdf::Analysers::PdfProperties.new.call(content, spreads)

        if spreads
          spread = pdf_properties[:page_numbers].detect{ |s| s.include?(page_number) }
          spread_number = pdf_properties[:page_numbers].index(spread)
          spread_side = spread.index(page_number)

          pdf_page_number = spread_number

          pdf = PDF::Reader.new(content.path)
          box = pdf.pages[pdf_page_number].attributes[:MediaBox] || pdf.pages[pdf_page_number].attributes[:CropBox]

          crop_box = box
          crop_box[2] = crop_box[2]/2
          crop_box[0] += crop_box[2] * spread_side
          crop_box[2] += crop_box[2] * spread_side

          crop_args = "-c '[/CropBox [#{crop_box.join(' ')}] /PAGES pdfmark'"
        end

        content.shell_update(ext: :pdf) do |old_path, new_path|
          "#{gs_command} -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dFirstPage=#{pdf_page_number+1} -dLastPage=#{pdf_page_number+1} -o #{new_path} #{crop_args} -f #{old_path}"
        end
      end


      private # =============================================================
      
      def gs_command
        'gs'
      end

    end
  end
end
