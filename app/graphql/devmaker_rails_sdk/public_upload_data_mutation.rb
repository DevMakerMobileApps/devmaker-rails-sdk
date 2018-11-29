module DevmakerRailsSdk
  class PublicUploadDataMutation < ::Mutations::BaseMutation
    include DevmakerRailsSdk::ErrorHandlingMutationMixin
    include DevmakerRailsSdk::HandleLoginMutationMixin

    argument :client_id, String, required: true
    argument :client_secret, String, required: true

    field :upload, DevmakerRailsSdk::Types::UploadDataType, null: true
    field :errors, [String], null: true

    def resolve(params)
      return invalid_client_error unless find_doorkeeper_app(params)
      upload = ::S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: "201", acl: "public-read")
      {upload: upload}
    end
  end
end
