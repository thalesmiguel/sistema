class CreateRacas < ActiveRecord::Migration[5.0]
  def change
    create_table :racas do |t|
      t.string :nome
      t.integer :especie

      t.timestamps
    end
  end
end
