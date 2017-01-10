class CreateTelefones < ActiveRecord::Migration[5.0]
  def change
    create_table :telefones do |t|
      t.integer :tipo
      t.string :ddi, default: "55"
      t.string :ddd
      t.string :numero
      t.string :ramal
      t.string :nome_contato
      t.integer :importancia
      t.boolean :telemarketing, default: true
      t.boolean :divulgar
      t.boolean :ativo, default: true

      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
