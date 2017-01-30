class CreateLeilaoCanais < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_canais do |t|
      t.references :leilao, foreign_key: true
      t.references :canal, foreign_key: true

      t.timestamps
    end
  end
end
