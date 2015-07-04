module EbookLibrary
  module Factory
    class Pdf
      attr_reader :metadata
      def initialize(metadata)
        @metadata = metadata
      end

      def author
        nil
      end

      def title
        nil
      end
    end
  end
end

