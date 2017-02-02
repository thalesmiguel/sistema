class CreateVeiculos < ActiveRecord::Migration[5.0]
  def change
    create_table :veiculos do |t|
      t.boolean :disponivel_viagem
      t.string :modelo
      t.integer :ano
      t.string :chassi
      t.string :placa
      t.string :renavam
      t.string :motor
      t.date :data_compra
      t.string :nf
      t.integer :ocupantes
      t.integer :media
      t.integer :combustivel

      t.timestamps
    end
  end
end
