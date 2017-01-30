class CreateLeilaoRacas < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_racas do |t|
      t.references :leilao, foreign_key: true
      t.references :raca, foreign_key: true

      t.timestamps
    end
  end
end
