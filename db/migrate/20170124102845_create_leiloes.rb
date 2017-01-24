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
      t.integer :testemunha_1_id
      t.integer :testemunha_2_id
      t.integer :situacao
      t.integer :leilao_anterior_id
      t.integer :subtipo_lotes_id
      t.attachment :logo

      t.timestamps
    end
    add_foreign_key :leiloes, :leiloes, column: :leilao_anterior_id, primary_key: :id
    add_foreign_key :leiloes, :users, column: :testemunha_1_id, primary_key: :id
    add_foreign_key :leiloes, :users, column: :testemunha_2_id, primary_key: :id
    add_foreign_key :leiloes, :subtipos, column: :subtipo_lotes_id, primary_key: :id
  end
end
