# this could possibly use the ebook-meta tool
#   http://manual.calibre-ebook.com/cli/ebook-meta.html
#
# reference:
#   http://wiki.mobileread.com/wiki/MOBI
require 'epub/parser'
require 'pdf-reader'

module EbookLibrary
  class Gatherer
    attr_accessor :path

    def initialize(path=EbookLibrary.default_path)
      @path = path if File.exist?(path)
      raise InvalidPath if @path.nil?
    end

    def self.gather
      new.gather
    end

    def gather
      results = gather_metadatas.inject([]) do |result, meta|
        begin
          result << {
              author: meta.author.encode('UTF-8', encode_options),
              title: meta.title.encode('UTF-8', encode_options),
              format: 'mobi',
              path: ""
          }
        rescue
          next
        end
      end
      {books: results}
    end

    def encode_options
      {invalid: :replace, undef: :replace, replace: '?'}
    end

    private

    def gather_metadatas
      Dir["#{path}/*"].inject([]) do |metadatas, book_path|
        metadatas << metadata_for(book_path)
      end
    end

    def metadata_for(book_path)
      case File.extname(book_path)
      when ".epub"
        # epub-parser
        ::EPUB::Parser.parse(book_path).metadata
      when ".mobi"
        # mobi
        ::Mobi.metadata File.open book_path
      when ".pdf"
        # pdf-reader
        ::PDF::Reader.new(book_path).metadata
      end
    end
  end
end
