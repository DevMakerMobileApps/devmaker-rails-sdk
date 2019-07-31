module Types
  module USERNAME
    class QueryType < Types::BaseObject
      field :me, Types::Models::USERNAMEType, null: false

      def me
        context[:current_DOWNUSERNAME]
      end
    end
  end
end
