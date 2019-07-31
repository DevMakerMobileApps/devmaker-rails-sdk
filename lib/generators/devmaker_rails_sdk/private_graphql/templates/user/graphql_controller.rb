class USERNAME::GraphqlController < USERNAMEController
  skip_before_action :verify_authenticity_token, only: [:execute]
  include GraphqlControllerMixin

  def schema
    USERNAMESchema
  end

  def context
    {
        current_user: current_user,
        current_DOWNUSERNAME: current_DOWNUSERNAME,
    }
  end
end
