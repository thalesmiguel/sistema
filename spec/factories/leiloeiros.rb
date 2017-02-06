FactoryGirl.define do
  factory :leiloeiro do
    nome_contrato "MyString"
    razao_social "MyString"
    cpf "MyString"
    cnpj "MyString"
    sindicato "MyString"
    endereco "MyString"
    cidade nil
    cep "MyString"
    email "MyString"
    telefone "MyString"
    fax "MyString"
    sigla "MS"
    cliente nil
    foto { File.new("#{Rails.root}/spec/support/fixtures/imagem.png") }
    comissao_elite "9.99"
    comissao_virtual "9.99"
    comissao_corte "9.99"
    comissao_shopping "9.99"
    comissao_contrato false
  end
end
