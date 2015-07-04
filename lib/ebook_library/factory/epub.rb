module EbookLibrary
  module Factory
    class Epub
      attr_reader :metadata
      def initialize(metadata)
        @metadata = metadata
      end

      def author
        metadata.creators.map(&:content).join(" ")
      end

      def title
        metadata.title || metadata.titles
      end
    end
  end
end

