# this could possibly use the ebook-meta tool
#   http://manual.calibre-ebook.com/cli/ebook-meta.html
#
# reference:
#   http://wiki.mobileread.com/wiki/MOBI
require 'epub/parser'
require 'pdf-reader'
require 'mobi'
require 'monadic'
require 'byebug'

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
            author: Maybe(meta).author._("").encode('UTF-8', encode_options),
            title: Maybe(meta).title._("untitled").encode('UTF-8', encode_options),
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
      Dir.glob("#{path}/**/*").inject([]) do |metadatas, book_path|
        metadatas << metadata_for(book_path)
      end
    end

    def metadata_for(book_path)
      @book = File.open book_path
      %i(parse_epub parse_mobi parse_pdf).inject(nil) do |parsed, parser|
        begin
          parsed || send(parser, @book)
        rescue
          nil
        end
      end
    end

    def parse_epub
      ::EPUB::Parser.parse(book_path).metadata
    end

    def parse_mobi
      ::Mobi.metadata book
    end

    def parse_pdf
      ::PDF::Reader.new(book).metadata
    end
  end
end
