require_relative '../analysers/pdf_properties'

module DragonflyPdf
  module Processors
    class PageThumb
      def call content, page_number=1, opts={}
        @content = content
        @page_number = page_number
        @format = opts['format'] || :png
        @density = opts['density'] || 150

        raise DragonflyPdf::PageNotFound unless pdf_properties[:page_numbers].include?(@page_number)

        content.shell_update(ext: @format) do |old_path, new_path|
          "#{convert_command} #{old_path}[#{pdf_page_number}] #{new_path}"
        end

        @content.meta['format'] = format.to_s
        @content.ext = format
      end

      def update_url attrs, page_number, opts={}
        format = opts['format']
        attrs.page_number = page_number
        attrs.ext = format if format
      end

      private # =============================================================

      def pdf_properties
        @pdf_properties ||= DragonflyPdf::Analysers::PdfProperties.new.call(@content)
      end

      def convert_command
        "convert -alpha deactivate -background white -colorspace sRGB -density #{@density}x#{@density} -define pdf:use-cropbox=true -define pdf:use-trimbox=true"
      end

      def pdf_page_number
        @page_number-1
      end
    end
  end
end
