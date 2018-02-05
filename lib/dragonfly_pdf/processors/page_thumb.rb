module DragonflyPdf
  module Processors
    class PageThumb
      def call(content, page, geometry = nil, options = {})
        options = options.deep_symbolize_keys
        format = options.delete(:format) { :jpg }

        convert(content, page, geometry, format)

        unless %i[pdf png svg].include?(format.to_sym)
          thumb(content, geometry, format, options)
        end

        content.meta['format'] = format.to_s
        content.ext = format
        content.meta['mime_type'] = nil # don't need it as we have ext now
      end

      def update_url(attrs, page, geometry=nil, options = {})
        options = options.deep_symbolize_keys
        format = options.fetch(:format, :jpg)
        attrs.ext = format.to_s
      end

      private # =============================================================

      def convert(content, page, geometry, format)
        convert_format = case format
                         when :pdf, :svg then format
                         else :png
        end
        content.process!(:convert, page, geometry, { format: convert_format })
      end

      def thumb(content, geometry, format, options)
        content.process!(:thumb, geometry, options.merge(format: format))
      end
    end
  end
end
