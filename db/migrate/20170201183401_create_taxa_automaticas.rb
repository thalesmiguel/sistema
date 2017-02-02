class CreateTaxaAutomaticas < ActiveRecord::Migration[5.0]
  def change
    create_table :taxa_automaticas do |t|
      t.integer :tipo
      t.string :nome
      t.string :nome_resumido
      t.integer :cobranca_por
      t.integer :cobranca_lote_tipo
      t.text :cobrado_de

      t.integer :lote_a_cada
      t.monetize :lote_valor, currency: { default: 'BRTX' }

      t.integer :macho_a_cada
      t.integer :macho_intervalo_inicio
      t.integer :macho_intervalo_fim
      t.monetize :macho_valor, currency: { default: 'BRTX' }
      t.boolean :macho_somente_sem_registro

      t.integer :femea_a_cada
      t.integer :femea_intervalo_inicio
      t.integer :femea_intervalo_fim
      t.monetize :femea_valor, currency: { default: 'BRTX' }
      t.boolean :femea_somente_sem_registro

      t.integer :sem_sexo_a_cada
      t.integer :sem_sexo_intervalo_inicio
      t.integer :sem_sexo_intervalo_fim
      t.monetize :sem_sexo_valor, currency: { default: 'BRTX' }
      t.boolean :sem_sexo_somente_sem_registro

      t.references :leilao, foreign_key: true

      t.timestamps
    end
  end
end
