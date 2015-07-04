module EbookLibrary
  module Factory
    class Null
      def initialize(metadata)
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
