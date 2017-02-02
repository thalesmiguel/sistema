class CreateUniformes < ActiveRecord::Migration[5.0]
  def change
    create_table :uniformes do |t|
      t.string :nome
      t.integer :sexo

      t.timestamps
    end
  end
end
