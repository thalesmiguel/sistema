FactoryGirl.define do
  factory :lancar_autorizado do
    nome "MyString"
    cpf "MyString"
    observacao "MyString"
    tem_procuracao false
    ativo true
    procuracao { File.new("#{Rails.root}/spec/support/fixtures/arquivo.pdf") }
    cliente nil
  end
end
