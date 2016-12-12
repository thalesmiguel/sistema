class CreateEnderecos < ActiveRecord::Migration[5.0]
  def change
    create_table :enderecos do |t|
      t.integer :tipo
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :caixa_postal
      t.string :bairro
      t.references :cidade, foreign_key: true
      t.string :pais
      t.string :cep
      t.string :aos_cuidados
      t.boolean :primario, default: true
      t.boolean :ativo, default: true

      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
