FactoryGirl.define do
  factory :assessoria do
    nome "MyString"
    observacao "MyText"
    logo { File.new("#{Rails.root}/spec/support/fixtures/imagem.png") }
  end
end
