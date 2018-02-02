module DragonflyPdf
  module Processors
    class Append
      def call(content, pdfs_to_append, _options = {})
        content.shell_update(ext: :pdf) do |old_path, new_path|
          "#{pdftk_command} #{old_path} #{pdfs_to_append.map(&:path).join(' ')} cat output #{new_path}"
        end
      end

      private

      def pdftk_command
        'pdftk'
      end
    end
  end
end
