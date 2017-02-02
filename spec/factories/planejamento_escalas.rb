FactoryGirl.define do
  factory :planejamento_escala do
    funcionario 1
    funcao nil
    uniforme nil
    diaria_valor 1.25
    diaria_descricao "MyString"
    despesa_valor 1.25
    despesa_descricao "MyString"
    avaliacao "MyString"
    avaliacao_observacao "MyString"
    leilao nil
  end
end
