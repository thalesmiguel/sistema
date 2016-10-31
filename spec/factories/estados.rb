FactoryGirl.define do
  factory :estado do
    sequence(:nome) { |n| "Nome#{n}" }
    sigla "SP"
  end
end
