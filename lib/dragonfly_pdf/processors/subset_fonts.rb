module DragonflyPdf
  module Processors
    class SubsetFonts
      def call content, opts={}
        content.shell_update(ext: :pdf) do |old_path, new_path|
          "#{gs_command} -o #{new_path} -f #{old_path}"
        end
      end

      private # =============================================================

      def gs_command
        "gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSubsetFonts=true"
      end
    end
  end
end
