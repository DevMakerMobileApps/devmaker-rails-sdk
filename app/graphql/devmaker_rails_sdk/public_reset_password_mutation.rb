module DevmakerRailsSdk
  class PublicResetPasswordMutation < ::Mutations::BaseMutation
    include DevmakerRailsSdk::ErrorHandlingMutationMixin
    include DevmakerRailsSdk::HandleLoginMutationMixin

    argument :client_id, String, required: true
    argument :client_secret, String, required: true
    argument :email, String, required: true

    field :success, Boolean, null: false

    def scoped_users
      raise "Define a #scoped_users at the child mutation from PublicResetPasswordMutation"
    end

    def resolve(params)
      user = scoped_users.find_for_database_authentication(email: params[:email])

      user&.send_reset_password_instructions

      return {success: true}
    end
  end
end
