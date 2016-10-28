FactoryGirl.define do
  factory :cidade do
    sequence(:nome) { |n| "Nome#{n}" }
    estado nil
  end
end
