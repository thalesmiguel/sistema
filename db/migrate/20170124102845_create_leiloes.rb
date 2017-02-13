class CreateLeiloes < ActiveRecord::Migration[5.0]
  def change
    create_table :leiloes do |t|
      t.integer :categoria
      t.integer :modalidade
      t.string :nome
      t.datetime :data_inicio
      t.datetime :data_fim
      t.string :nome_agenda
      t.string :nome_site
      t.references :cidade, foreign_key: true
      t.integer :tipo
      t.integer :situacao
      t.integer :testemunha_1_id
      t.integer :testemunha_2_id
      t.integer :leilao_anterior_id
      t.integer :subtipo_lotes_id
      t.text :observacao_nota_mapa
      t.attachment :logo
      t.references :leilao_evento, foreign_key: true

      t.timestamps
    end
  end
end
