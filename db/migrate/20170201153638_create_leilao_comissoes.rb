class CreateLeilaoComissoes < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_comissoes do |t|
      t.integer :tipo
      t.monetize :valor_fixo_venda
      t.integer :perc_venda_promotor
      t.integer :perc_venda_convidado_elite
      t.integer :perc_venda_convidado_corte
      t.integer :perc_compra_elite
      t.integer :perc_compra_corte
      t.boolean :cobra_comissao_retornos
      t.string :financ_comissao_compra
      t.string :financ_comissao_venda
      t.string :financ_solicitacao_entrada
      t.references :leilao, foreign_key: true
      t.integer :promotor_banco_id

      t.timestamps
    end
  end
end
