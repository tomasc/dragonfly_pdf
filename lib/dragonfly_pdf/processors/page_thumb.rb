require_relative '../analysers/pdf_properties'

module DragonflyPdf
  module Processors
    class PageThumb
      attr_reader :content, :density, :page_number, :format

      def call(content, page_number = 1, opts = {})
        @content = content
        @page_number = page_number
        @format = opts['format'] || :png
        @density = opts['density'] || 150

        content.shell_update(ext: @format) do |old_path, new_path|
          "#{gs_command} -o '#{new_path}' -f '#{old_path}'"
        end

        @content.meta['format'] = @format.to_s
        @content.ext = @format
      end

      def update_url(attrs, page_number, opts = {})
        format = opts['format']
        attrs.page_number = page_number
        attrs.ext = format if format
      end

      private # =============================================================

      def gs_command
        "gs -sDEVICE=#{gs_format} -r#{density} -dTextAlphaBits=4 -dUseArtBox -dFirstPage=#{page_number} -dLastPage=#{page_number}"
      end


      def gs_format
        case @format
        when :png then :png16m
        when :jpg, :jpeg then :jpeg
        when :tif, :tiff then :tiff48nc
        else :jpeg
        end
      end
    end
  end
end
