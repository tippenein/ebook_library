require 'epub/parser'
require 'pdf-reader'
require 'mobi'

module EbookLibrary
  class Ebook
    attr_reader :raw_ebook, :path, :adapter
    def initialize(ebook_path)
      @path = ebook_path
      @raw_ebook = File.open ebook_path
      @adapter = get_adapter
    end

    def title
      adapter.title
    end

    def author
      adapter.author
    end

    def format
      @format ||= File.extname(path).gsub(/^./, "")
    end

    def to_hash
      Hash[attrs.map{|attr| [attr, send(attr)]}] if valid?
    end

    def has_metadata?
      !metadata.nil?
    end

    def valid?
      EbookFactory.supported_types.include?(format)
    end

    private

    def get_adapter
      EbookFactory.new(format, metadata)
    end

    def attrs
      [:title, :author, :format]
    end

    def metadata
      %i(parse_mobi parse_epub parse_pdf).inject(nil) do |parsed, parser|
        begin
          parsed || send(parser)
        rescue
          nil
        end
      end
    end

    def parse_epub
      ::EPUB::Parser.parse(path).metadata
    end

    def parse_mobi
      ::Mobi.metadata raw_ebook
    end

    def parse_pdf
      ::PDF::Reader.new(raw_book).metadata
    end
  end
end
