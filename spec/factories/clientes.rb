FactoryGirl.define do
  factory :cliente do
    sequence(:nome) { |n| "Nome#{n}" }
    apelido "MyString"
    ficticio "MyString"
    sexo Cliente.sexos[:masculino]
    data_nascimento "2016-10-28"
    inscricao_estadual "MyString"
    sequence(:cpf_cnpj) { |n| "370.629.888.0#{n}" }
    rg "44.950.175-9"
    rg_emissor "SSP"
    rg_data_emissao "2016-10-28"
    pessoa_tipo Cliente.pessoa_tipos[:física]
    cadastro_tipo Cliente.cadastro_tipos[:cliente]
    marketing_tipos ["mala_direta", "fax", "e-mail"]
  end
end
