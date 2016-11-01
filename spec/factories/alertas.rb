FactoryGirl.define do
  factory :alerta do
    tipo Alerta.tipos[:observação]
    descricao "MyText"
    ativo true
    cliente nil
  end
end
