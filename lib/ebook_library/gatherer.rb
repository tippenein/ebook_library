# this could possibly use the ebook-meta tool
#   http://manual.calibre-ebook.com/cli/ebook-meta.html
#
# reference:
#   http://wiki.mobileread.com/wiki/MOBI

module EbookLibrary
  class Gatherer
    attr_accessor :path

    def initialize(path=EbookLibrary.default_path)
      @path = path if File.exist?(path)
      raise InvalidPath if @path.nil?
    end

    def gather
      results = gather_ebooks.map do |book_path|
        begin
          ebook = Ebook.new(book_path)
          ebook.to_hash
        rescue EbookLibrary::UnsupportedFormatError
          puts "skipping: " + book_path
        end
      end
      { books: results.compact }
    end

    private

    # returns [FilePath]
    def gather_ebooks
      Dir.glob("#{path}/**/*").inject([]) do |paths, book_path|
        paths << book_path
      end
    end
  end
end
