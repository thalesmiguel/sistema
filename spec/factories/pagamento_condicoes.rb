FactoryGirl.define do
  factory :pagamento_condicao do
    nome "MyString"
    tipo "período_de_dias"
    captacoes 1
    parcelas 1
    frequencia 1
    entrada false
  end
end
