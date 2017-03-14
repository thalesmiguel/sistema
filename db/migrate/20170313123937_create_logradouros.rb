class CreateLogradouros < ActiveRecord::Migration[5.0]
  def change
    create_table :logradouros do |t|
      t.string :nome
      t.integer :cep
      t.string :complemento

      t.references :bairro, foreign_key: true

      t.timestamps
    end
  end
end
