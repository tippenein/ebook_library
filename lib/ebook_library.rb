require "ebook_library/version"
require "ebook_library/gatherer"

module EbookLibrary
  def self.default_path
    File.join ENV["HOME"], "Dropbox/ebooks"
  end

  def self.generate(type=:json)
    require 'json' if type.to_sym == :json
    Gatherer.gather.to_json
  end

  class InvalidPath < StandardError; end
end
