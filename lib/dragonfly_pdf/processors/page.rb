require 'pdf-reader'
require_relative '../errors'
require_relative '../analysers/pdf_properties'

module DragonflyPdf
  module Processors
    class Page
      def call content, page_number=1, opts={}
        pdf_page_number = page_number
        crop_args = ''
        pdf_properties = DragonflyPdf::Analysers::PdfProperties.new.call(content)

        raise DragonflyPdf::PageNotFound unless pdf_properties[:page_numbers].flatten.include?(page_number)

        content.shell_update(ext: :pdf) do |old_path, new_path|
          "#{gs_command} -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dFirstPage=#{pdf_page_number} -dLastPage=#{pdf_page_number} -o #{new_path} #{crop_args} -f #{old_path}"
        end
      end


      private # =============================================================
      
      def gs_command
        'gs'
      end
    end
  end
end
