FactoryGirl.define do
  factory :user do
    username "test.user"
    email "user@example.com"
    password "password"
    password_confirmation "password"
  end
end
