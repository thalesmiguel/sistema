FactoryGirl.define do
  factory :alerta do
    tipo 'faturamento'
    descricao "MyText MyText"
    ativo true
    cliente nil
  end
end
