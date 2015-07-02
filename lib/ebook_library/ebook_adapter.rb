require 'monadic'
module EbookLibrary
  class EbookAdapter
    attr_reader :metadata
    def initialize(metadata)
      @metadata = metadata
    end

    def title
      Maybe(metadata).title._("untitled").encode('UTF-8', encode_options)
    end

    def author
      Maybe(metadata).author._("").encode('UTF-8', encode_options)
    end

    private
    #TODO move these to config
    def encode_options
      {invalid: :replace, undef: :replace, replace: '?'}
    end

  end
end
