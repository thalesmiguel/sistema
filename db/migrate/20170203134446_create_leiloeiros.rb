class CreateLeiloeiros < ActiveRecord::Migration[5.0]
  def change
    create_table :leiloeiros do |t|
      t.string :nome_contrato
      t.string :razao_social
      t.string :cpf
      t.string :cnpj
      t.string :sindicato
      t.string :endereco
      t.references :cidade, foreign_key: true
      t.string :cep
      t.string :email
      t.string :telefone
      t.string :fax
      t.string :sigla
      t.attachment :foto
      t.decimal :comissao_elite, precision: 16, scale: 2, default: 0
      t.decimal :comissao_virtual, precision: 16, scale: 2, default: 0
      t.decimal :comissao_corte, precision: 16, scale: 2, default: 0
      t.decimal :comissao_shopping, precision: 16, scale: 2, default: 0
      t.boolean :comissao_contrato, default: false

      t.timestamps
    end
  end
end
