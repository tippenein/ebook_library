require "ebook_library/version"
require "ebook_library/gatherer"

module EbookLibrary
  def self.default_path
    File.join ENV["HOME"], "Dropbox/ebooks"
  end

  class InvalidPath < StandardError; end
end
