require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a admin? scope" do

    admin = FactoryBot.create(:admin)

    user_admin = FactoryBot.create(:user, owner: admin)

    expect(user_admin).to be_admin

    expect(User.admins).to include(user_admin)

  end
end
