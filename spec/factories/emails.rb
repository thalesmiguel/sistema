FactoryGirl.define do
  factory :email do
    sequence(:email) { |n| "email#{n}@email.com" }
    contato "MyString"
    mala_direta true
    solicitacao_email true
    envio_contratos true
    ativo true
    cliente nil
  end
end
