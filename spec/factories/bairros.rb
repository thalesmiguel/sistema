FactoryGirl.define do
  factory :bairro do
    sequence(:nome) { |n| "Nome#{n}" }
    cidade nil
  end
end
