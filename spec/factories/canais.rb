FactoryGirl.define do
  factory :canal do
    nome "MyString"
    observacao "MyText"
    inf_transmissao "MyText"
    logo { File.new("#{Rails.root}/spec/support/fixtures/imagem.png") }
  end
end
