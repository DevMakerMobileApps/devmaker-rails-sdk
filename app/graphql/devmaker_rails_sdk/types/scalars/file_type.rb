module DevmakerRailsSdk
  module Types
    module Scalars
      class FileType < ::Types::BaseScalar
        graphql_name "File"
        description "Action Dispatch Uploaded File"

        def self.coerce_input(file, context)
          return nil if file.nil?

          ActionDispatch::Http::UploadedFile.new(
            filename: file.original_filename,
            type: file.content_type,
            head: file.headers,
            tempfile: file.tempfile,
          )
        end
      end
    end
  end
end
