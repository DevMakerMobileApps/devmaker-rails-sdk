module DevmakerRailsSdk
  module Types
    class UploadDataType < ::Types::BaseObject
      field :url, String, null: false
      field :fields, String, null: false

      def fields
        object.fields.to_json
      end
    end
  end
end
