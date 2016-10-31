FactoryGirl.define do
  factory :banco do
    sequence(:codigo) { |n| n }
    nome "MyString"
  end
end
