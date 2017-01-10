FactoryGirl.define do
  factory :fazenda do
    nome "MyString"
    cidade nil
    cep "MyString"
    tipo 'não_informado'
    endereco "MyString"
    area "MyString"
    observacao "MyText"
    inscricao_estadual "MyString"
    cnpj_fazenda "MyString"
    incra "MyString"
    cnpj_produtor "MyString"
    nome_nf "MyString"
    cpf_cnpj_nf "MyString"
    ativo true
    cliente nil
  end
end
