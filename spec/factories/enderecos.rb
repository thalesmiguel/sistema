FactoryGirl.define do
  factory :endereco do
    tipo Endereco.tipos[:correspondência]
    logradouro "MyString"
    numero "MyString"
    complemento "MyString"
    caixa_postal "MyString"
    bairro "MyString"
    cidade nil
    pais "MyString"
    cep "MyString"
    aos_cuidados "MyString"
    primario true
    ativo true
    cliente nil
  end
end
