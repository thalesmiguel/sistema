class CreateFazendas < ActiveRecord::Migration[5.0]
  def change
    create_table :fazendas do |t|
      t.string :nome
      t.references :cidade, foreign_key: true
      t.string :cep
      t.integer :tipo
      t.string :endereco
      t.string :area
      t.text :observacao
      t.string :inscricao_estadual
      t.string :cnpj_fazenda
      t.string :incra
      t.string :cnpj_produtor
      t.boolean :faz_terceiro
      t.string :nome_nf
      t.string :cpf_cnpj_nf
      t.boolean :ativo, default: true
      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
