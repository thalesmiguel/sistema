class CreateClientes < ActiveRecord::Migration[5.0]
  def change
    create_table :clientes do |t|
      t.string :nome
      t.string :apelido
      t.string :ficticio
      t.integer :sexo
      t.date :data_nascimento
      t.string :inscricao_estadual
      t.string :cpf_cnpj
      t.string :rg
      t.string :rg_emissor
      t.date :rg_data_emissao
      t.integer :pessoa_tipo
      t.integer :cadastro_tipo
      t.text :marketing_tipos

      t.timestamps
    end
  end
end
