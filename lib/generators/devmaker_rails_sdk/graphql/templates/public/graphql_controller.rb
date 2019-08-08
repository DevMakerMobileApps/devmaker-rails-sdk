class Public::GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:execute]
  include GraphqlControllerMixin

  def schema
    PublicSchema
  end
end
