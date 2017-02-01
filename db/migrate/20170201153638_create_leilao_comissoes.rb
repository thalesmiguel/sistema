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
      t.references :leilao, foreign_key: true

      t.timestamps
    end
  end
end
