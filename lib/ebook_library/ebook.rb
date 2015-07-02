require 'epub/parser'
require 'pdf-reader'
require 'mobi'

module EbookLibrary
  class Ebook
    attr_reader :raw_ebook, :path, :adapter
    def initialize(ebook_path)
      @path = ebook_path
      @raw_ebook = File.open ebook_path
      @adapter = EbookAdapter.new(metadata)
    end

    def title
      adapter.title
    end

    def author
      adapter.author
    end

    def format
      # get this from the raw ebook
    end

    def to_hash
      Hash[attrs.map{|sym| [sym, send(sym)]}]
    end

    def metadata
      %i(parse_epub parse_mobi parse_pdf).inject(nil) do |parsed, parser|
        begin
          parsed || send(parser, book)
        rescue
          nil
        end
      end
    end

    def has_metadata?
      !metadata.nil?
    end

    private

    def attrs
      [:title, :author, :format]
    end

    def parse_epub
      ::EPUB::Parser.parse(path).metadata
    end

    def parse_mobi
      ::Mobi.metadata raw_book
    end

    def parse_pdf
      ::PDF::Reader.new(raw_book).metadata
    end
  end
end
