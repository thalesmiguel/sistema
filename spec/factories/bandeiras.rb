FactoryGirl.define do
  factory :bandeira do
    nome "MyString"
    sigla "MyString"
    cor "MyString"
    logo { File.new("#{Rails.root}/spec/support/fixtures/imagem.png") }
  end
end
