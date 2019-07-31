module Types
  module Public
    class QueryType < Types::BaseObject
      field :test, String, null: false

      def test
        'oi'
      end
    end
  end
end
