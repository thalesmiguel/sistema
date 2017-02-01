class CreateTaxaAutomaticas < ActiveRecord::Migration[5.0]
  def change
    create_table :taxa_automaticas do |t|
      t.integer :tipo
      t.string :nome
      t.string :nome_resumido
      t.integer :cobranca_por
      t.integer :cobranca_lote_tipo
      t.text :cobrado_de
      t.integer :a_cada
      t.integer :intervalo_inicio
      t.integer :intervalo_fim
      t.monetize :valor, currency: { default: 'BRTX' }
      t.references :leilao, foreign_key: true

      t.timestamps
    end
  end
end
