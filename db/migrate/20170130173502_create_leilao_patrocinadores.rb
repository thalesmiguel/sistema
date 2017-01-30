class CreateLeilaoPatrocinadores < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_patrocinadores do |t|
      t.references :leilao, foreign_key: true
      t.references :patrocinador, foreign_key: true

      t.timestamps
    end
  end
end
