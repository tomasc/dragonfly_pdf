require_relative '../analysers/pdf_properties'

module DragonflyPdf
  module Processors
    class PageThumb

      def call content, page_number=1, opts={}
        format = opts.fetch(:format, :png)
        density = opts.fetch(:density, 600)
        spreads = content.meta['spreads'] || false

        args = "-alpha deactivate -background white -colorspace sRGB -density #{density}x#{density} -define pdf:use-cropbox=true -define pdf:use-trimbox=true"
        crop_args = ''

        pdf_properties = DragonflyPdf::Analysers::PdfProperties.new.call(content)

        raise DragonflyPdf::PageNotFound unless pdf_properties[:page_numbers].flatten.include?(page_number)

        if spreads
          spread = pdf_properties[:page_numbers].detect{ |s| s.include?(page_number) }
          spread_number = pdf_properties[:page_numbers].index(spread)
          spread_side = spread.index(page_number)
          page_to_delete = 1-spread_side

          pdf_page_number = spread_number
          crop_args = "-crop 50%x100% -delete #{page_to_delete}"
        else
          pdf_page_number = page_number-1
        end

        content.shell_update(ext: format) do |old_path, new_path|
          "#{convert_command} #{args} #{crop_args} #{old_path}[#{pdf_page_number}] #{new_path}"
        end

        content.meta['format'] = format.to_s
        content.ext = format
      end

      def update_url attrs, args='', opts={}
        format = opts['format']
        attrs.ext = format if format
      end

      private # =============================================================

      def convert_command
        'convert'
      end

      def pdf_page_number page_number, spreads
        return 1
      end

      def pdf_crop_args page_number, spreads
        return
      end

    end
  end
end