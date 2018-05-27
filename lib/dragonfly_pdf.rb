require 'dragonfly'
require 'dragonfly_libvips'
require 'dragonfly_pdf/plugin'
require 'dragonfly_pdf/version'

module DragonflyPdf
  class PageNotFound < RuntimeError; end
  class UnsupportedFormat < RuntimeError; end

  SUPPORTED_FORMATS = %w[pdf].freeze
  SUPPORTED_OUTPUT_FORMATS = %w[png pam pbm pkm pnm pdf tga svg].uniq.sort
end
