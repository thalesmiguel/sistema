FactoryGirl.define do
  factory :leilao do
    categoria "elite"
    modalidade "recinto"
    nome "MyString"
    data_inicio "2017-01-24 08:28:45"
    data_fim "2017-01-24 08:28:45"
    nome_agenda "MyString"
    nome_site "MyString"
    cidade nil
    tipo "leilão_normal"
    testemunha_1 nil
    testemunha_2 nil
    situacao 1
    logo { File.new("#{Rails.root}/spec/support/fixtures/imagem.png") }
  end
end
