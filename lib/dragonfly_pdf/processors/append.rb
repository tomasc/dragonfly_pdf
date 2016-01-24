require 'combine_pdf'

module DragonflyPdf
  module Processors
    class Append
      def call(content, pdfs_to_append, _options = {})
        result = CombinePDF.new

        ([content] + pdfs_to_append).each do |pdf|
          CombinePDF.parse(pdf.data).pages.each { |page| result << page }
        end

        content.update(result.to_pdf)
      end
    end
  end
end
