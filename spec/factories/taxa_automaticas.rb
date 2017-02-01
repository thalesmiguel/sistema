FactoryGirl.define do
  factory :taxa_automatica do
    tipo 1
    nome "MyString"
    nome_resumido "MyString"
    cobranca_por 1
    cobranca_lote_tipo 1
    cobrado_de (["vendidos", "defendidos", "retornados"])
    a_cada 1
    intervalo_inicio 1
    intervalo_fim 1
    valor 3.21
    leilao nil
  end
end
