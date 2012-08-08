FactoryGirl.define do
  factory :user do
    name "Factory User"
    email "factory@user.com"
    password "factory"
    password_confirmation "factory"
  end
end
