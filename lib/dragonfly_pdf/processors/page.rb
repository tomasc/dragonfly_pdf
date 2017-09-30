require_relative '../errors'
require_relative '../analysers/pdf_properties'

module DragonflyPdf
  module Processors
    class Page
      def call(content, page_number = 1, _opts = {})
        pdf_properties = DragonflyPdf::Analysers::PdfProperties.new.call(content)
        raise DragonflyPdf::PageNotFound unless pdf_properties[:page_numbers].include?(page_number)

        content.shell_update(ext: :pdf) do |old_path, new_path|
          "#{gs_command} -dFirstPage=#{page_number} -dLastPage=#{page_number} -o #{new_path} -f #{old_path}"
        end
      end

      private

      def gs_command
        'gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH'
      end
    end
  end
end
