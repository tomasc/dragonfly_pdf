module DragonflyPdf
  module Processors
    class Stamp
      def call(content, stamp_pdf, _options = {})
        content.shell_update(ext: :pdf) do |old_path, new_path|
          "#{pdftk_command} #{old_path} stamp #{stamp_pdf.path} output #{new_path}"
        end
      end

      private # =============================================================

      def pdftk_command
        'pdftk'
      end
    end
  end
end
