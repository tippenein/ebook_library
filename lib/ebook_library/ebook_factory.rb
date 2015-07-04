require 'monadic'
module EbookLibrary
  class EbookFactory
    attr_reader :adapter
    def initialize(format, metadata)
      @adapter = for_type(format).new(metadata)
    end

    def self.supported_types
      %w(epub mobi pdf)
    end

    def title
      Maybe(adapter).title._("untitled").encode('UTF-8', encode_options)
    end

    def author
      Maybe(adapter).author._("").encode('UTF-8', encode_options)
    end

    private
    #TODO move these to config
    def encode_options
      {invalid: :replace, undef: :replace, replace: '?'}
    end

    def for_type(format)
      case format
      when 'epub'
        Factory::Epub
      when 'mobi', 'azw'
        Factory::Mobi
      when 'pdf'
        Factory::Pdf
      end
    end
  end

  class UnsupportedFormatError < StandardError; end
end
