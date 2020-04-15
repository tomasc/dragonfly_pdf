module DragonflyPdf
  module Processors
    class Rotate
      def call(content, arg)
        raise UnsupportedFormat unless content.ext
        raise UnsupportedFormat unless SUPPORTED_FORMATS.include?(content.ext.downcase)

        rotate_args = case arg
                      when String, Symbol
                        raise ArgumentError unless arg.to_s =~ /north|south|east|west|left|right|down/i
                        "1-end#{arg}"
                      when Hash
                        pdf_properties = DragonflyPdf::Analysers::PdfProperties.new.call(content)
                        pdf_properties['page_numbers'].map { |page| [page, arg[page]].compact.join }.join(' ')
        end

        content.shell_update(ext: 'pdf') do |old_path, new_path|
          "#{pdftk_command} \"#{old_path}\" cat #{rotate_args} output #{new_path}"
        end
      end

      private

      def pdftk_command
        'pdftk'
      end
    end
  end
end
