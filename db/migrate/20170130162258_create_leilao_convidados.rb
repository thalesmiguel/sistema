class CreateLeilaoConvidados < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_convidados do |t|
      t.references :leilao, foreign_key: true
      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
