FactoryGirl.define do
  factory :veiculo do
    disponivel_viagem true
    modelo "MyString"
    ano 2017
    chassi "MyString"
    placa "MyString"
    renavam "MyString"
    motor "MyString"
    data_compra "2017-02-02"
    nf "MyString"
    ocupantes 1
    media 1
    combustivel 'gasolina'
  end
end
