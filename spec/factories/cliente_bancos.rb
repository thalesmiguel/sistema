FactoryGirl.define do
  factory :cliente_banco do
    banco nil
    agencia "MyString"
    conta_corrente "MyString"
    cidade nil
    data_abertura_conta "2016-10-31"
    observacao "MyText"
    correntista_nome "MyString"
    correntista_cpf_cnpj "MyString"
    primario true
    ativo true
    cliente nil
  end
end
