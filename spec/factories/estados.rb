FactoryGirl.define do
  factory :estado do
    sequence(:nome) { |n| "Nome#{n}" }
    sequence(:sigla) { |n| "S#{n}" }
  end
end
