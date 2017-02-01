FactoryGirl.define do
  factory :leilao_padrao do
    pagamento_elite_id nil
    pagamento_corte_id nil
    pagamento_outros_id nil
    leilao nil
    dolar 3.21
    arroba 150.01
  end
end
