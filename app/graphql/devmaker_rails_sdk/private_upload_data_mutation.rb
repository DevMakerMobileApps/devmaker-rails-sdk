module DevmakerRailsSdk
  class PrivateUploadDataMutation < ::Mutations::BaseMutation
    field :upload, DevmakerRailsSdk::Types::UploadDataType, null: true
    field :errors, [String], null: true

    def resolve
      upload = ::S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: "201", acl: "public-read")
      {upload: upload}
    end
  end
end
