FactoryGirl.define do
  factory :patrocinador do
    nome "MyString"
    logo { File.new("#{Rails.root}/spec/support/fixtures/imagem.png") }
  end
end
