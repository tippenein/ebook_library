module EbookLibrary
  module Factory
    class Mobi
      attr_reader :metadata
      def initialize(metadata)
        @metadata = metadata
      end

      def author
        metadata.author
      end

      def title
        metadata.title
      end
    end
  end
end
