require 'dragonfly'
require 'dragonfly_pdf/plugin'
require 'dragonfly_pdf/version'

module DragonflyPdf
  class UnsupportedFormat < RuntimeError; end

  SUPPORTED_FORMATS = %w[pdf].freeze
end
