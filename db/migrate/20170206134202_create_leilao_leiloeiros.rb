class CreateLeilaoLeiloeiros < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_leiloeiros do |t|
      t.references :leilao, foreign_key: true
      t.references :leiloeiro, foreign_key: true
      t.decimal :comissao, precision: 16, scale: 2

      t.timestamps
    end
  end
end
