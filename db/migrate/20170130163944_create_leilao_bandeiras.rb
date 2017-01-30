class CreateLeilaoBandeiras < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_bandeiras do |t|
      t.references :leilao, foreign_key: true
      t.references :bandeira, foreign_key: true

      t.timestamps
    end
  end
end
