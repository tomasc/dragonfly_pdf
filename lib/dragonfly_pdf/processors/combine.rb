require 'combine_pdf'
# require_relative '../errors'
# require_relative '../analysers/pdf_properties'

module DragonflyPdf
  module Processors
    class Combine
      def call(content, pdfs_to_append, options={})
        result = CombinePDF.new

        ([content] + pdfs_to_append).each do |pdf|
          CombinePDF.parse(pdf.data).pages.each { |page| result << page }
        end

        content.update(result.to_pdf)
      end

      private # =============================================================
    end
  end
end
