class CreateEmpresas < ActiveRecord::Migration[5.0]
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :cnpj
      t.string :cargo
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :bairro
      t.references :cidade, foreign_key: true
      t.string :cep
      t.string :caixa_postal
      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
