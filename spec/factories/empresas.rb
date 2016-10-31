FactoryGirl.define do
  factory :empresa do
    nome "MyString"
    cnpj "MyString"
    cargo "MyString"
    logradouro "MyString"
    numero "MyString"
    complemento "MyString"
    bairro "MyString"
    cidade nil
    cep "MyString"
    caixa_postal "MyString"
    cliente nil
  end
end
