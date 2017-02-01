FactoryGirl.define do
  factory :leilao_comissao do
    tipo "rateio_de_despesas"
    valor_fixo_venda 3.21
    perc_venda_promotor 1
    perc_venda_convidado_elite 1
    perc_venda_convidado_corte 1
    perc_compra_elite 1
    perc_compra_corte 1
    leilao nil
    promotor_banco nil
    financ_comissao_compra "asd"
    financ_comissao_venda "qasd"
    financ_solicitacao_entrada "asd"
  end
end
