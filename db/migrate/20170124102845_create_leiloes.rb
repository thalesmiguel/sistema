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
      t.integer :testemunha_1
      t.integer :testemunha_2
      t.integer :situacao
      t.attachment :logo

      t.timestamps

    end
    add_foreign_key :leiloes, :users, column: :testemunha_1
    add_foreign_key :leiloes, :users, column: :testemunha_2

  end
end
