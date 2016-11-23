FactoryGirl.define do
  factory :estado do
    sequence(:nome) { |n| "Nome#{n}" }
    sequence(:sigla) { [*('A'..'Z')].sample(2).join }
  end
end
