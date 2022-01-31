require 'dragonfly'
require 'dragonfly_libvips'
require 'dragonfly_pdf/plugin'
require 'dragonfly_pdf/version'

module DragonflyPdf
  class PageNotFound < RuntimeError; end
  class UnsupportedFormat < RuntimeError; end

  SUPPORTED_FORMATS = %w[pdf].freeze
  SUPPORTED_OUTPUT_FORMATS = %w[png pam pbm pkm pnm pdf svg].uniq.sort

  private

  def self.stringify_keys(hash = {})
    hash.each_with_object({}) { |(k, v), memo| memo[k.to_s] = v }
  end

  def self.symbolize_keys(hash = {})
    hash.each_with_object({}) { |(k, v), memo| memo[k.to_sym] = v }
  end
end
