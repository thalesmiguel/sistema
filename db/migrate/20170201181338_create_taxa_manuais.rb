class CreateTaxaManuais < ActiveRecord::Migration[5.0]
  def change
    create_table :taxa_manuais do |t|
      t.integer :tipo
      t.string :nome
      t.references :leilao, foreign_key: true

      t.timestamps
    end
  end
end
