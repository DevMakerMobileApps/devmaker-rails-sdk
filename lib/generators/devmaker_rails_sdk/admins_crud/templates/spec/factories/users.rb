FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "user6#{i}@user.com" }
    password { '123456' }
  end
end
