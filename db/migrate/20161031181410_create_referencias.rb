class CreateReferencias < ActiveRecord::Migration[5.0]
  def change
    create_table :referencias do |t|
      t.string :nome
      t.string :telefone
      t.string :observacao
      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
