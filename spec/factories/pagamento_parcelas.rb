FactoryGirl.define do
  factory :pagamento_parcela do
    parcela 1
    captacoes 1
    vencimento "2017-01-31"
    pagamento_condicao nil
  end
end
