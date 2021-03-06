class CreateAlertas < ActiveRecord::Migration[5.0]
  def change
    create_table :alertas do |t|
      t.integer :tipo
      t.text :descricao
      t.boolean :ativo, default: true
      t.references :cliente, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
