FactoryGirl.define do
  factory :lancar_autorizado do
    nome "MyString"
    cpf "MyString"
    observacao "MyString"
    tem_procuracao false
    ativo true
    cliente nil
  end
end
