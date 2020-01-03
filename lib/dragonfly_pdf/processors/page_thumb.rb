module DragonflyPdf
  module Processors
    class PageThumb
      def call(content, page, geometry = nil, options = {})
        raise UnsupportedFormat unless content.ext
        raise UnsupportedFormat unless SUPPORTED_FORMATS.include?(content.ext.downcase)

        options = DragonflyPdf.stringify_keys(options)
        format = options.delete('format') { 'jpg' }.to_s

        convert(content, page, geometry, format)

        unless %w[pdf png svg].include?(format)
          thumb(content, geometry, format, options)
        end

        content.meta['format'] = format
        content.ext = format
        content.meta['mime_type'] = nil # don't need it as we have ext now
      end

      def update_url(attrs, _page, _geometry = nil, options = {})
        options = options.each_with_object({}) { |(k, v), memo| memo[k.to_s] = v } # stringify keys
        attrs.ext = options.fetch('format', 'jpg').to_s
      end

      private

      def convert(content, page, geometry, format)
        convert_to_format = case format
                            when 'pdf', 'svg' then format
                            else 'png'
        end

        Convert.new.call(content, page, geometry, 'format' => convert_to_format)
      end

      def thumb(content, geometry, format, options)
        options['format'] = format
        DragonflyLibvips::Processors::Thumb.new.call(content, geometry, options)
      end
    end
  end
end
