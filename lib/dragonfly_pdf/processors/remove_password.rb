module DragonflyPdf
  module Processors
    class RemovePassword
      def call(content, _options = {})
        raise UnsupportedFormat unless content.ext
        raise UnsupportedFormat unless SUPPORTED_FORMATS.include?(content.ext.downcase)

        content.shell_update(ext: 'pdf') do |old_path, new_path|
          "#{gs_command} -q -sOutputFile=\"#{new_path}\" -c .setpdfwrite -f \"#{old_path}\""
        end
      end

      private

      def gs_command
        'gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite'
      end
    end
  end
end
