require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe "user relationship" do
    it "belong to a user" do
      admin = FactoryBot.create(:admin)

      expect(admin.user).to_not be_present

      user = FactoryBot.create(:user, owner: admin)

      expect(user.owner).to eql(admin)

      expect(admin.user).to eql(user)

    end

    it "accepts nested attributtes for user" do
      params = {
          user_attributes: {
              email: "admin@gmail.com",
              password: "123456",
          },
      }

      admin = Admin.create!(params)

      expect(admin.user.valid_password?("123456")).to be true
    end

    it "edit admin" do

      admin = FactoryBot.create(:admin)
      user = FactoryBot.create(:user, password: "1234562", owner: admin)


      params = {"name"=>"asd", "user_attributes"=>{id: user.id,"email"=>"admin@gmail.com"}}

      expect(admin.update(params)).to be true

    end
  end
end
