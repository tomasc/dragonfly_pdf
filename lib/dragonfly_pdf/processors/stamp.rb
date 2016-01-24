require 'combine_pdf'

module DragonflyPdf
  module Processors
    class Stamp
      def call(content, stamp_pdf, _options = {})
        stamp = CombinePDF.parse(stamp_pdf.data).pages[0]
        result = CombinePDF.parse(content.data)
        result.pages.each { |page| page << stamp }
        content.update(result.to_pdf)
      end
    end
  end
end
