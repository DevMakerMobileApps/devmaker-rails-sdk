module DevmakerRailsSdk
  module Types
    class UserTokenType < ::Types::BaseObject
      field :access_token, String, null: false, method: :token
      field :token_type, String, null: false
      field :expires_in, Int, null: false
      field :refresh_token, String, null: false
      field :created_at, Int, null: false
    end
  end
end
