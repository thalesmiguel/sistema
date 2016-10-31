FactoryGirl.define do
  factory :telefone do
    tipo Telefone.tipos[:canal]
    ddi "55"
    ddd "18"
    numero "99134-4423"
    ramal "MyString"
    nome_contato "MyString"
    importancia 1
    telemarketing true
    divulgar true
    ativo true

    cliente nil
  end
end
