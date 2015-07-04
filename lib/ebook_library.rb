require "ebook_library/version"
require "ebook_library/gatherer"
require "ebook_library/ebook"
require "ebook_library/ebook_factory"
require "ebook_library/factory/epub"
require "ebook_library/factory/mobi"
require "ebook_library/factory/pdf"

module EbookLibrary
  def self.default_path
    File.join ENV["HOME"], "Documents/mobi_lib/Philosophy\ and\ Science"
  end

  def self.generate(type=:json)
    require 'json' if type.to_sym == :json
    Gatherer.new.gather.to_json
  end

  class InvalidPath < StandardError; end
end
