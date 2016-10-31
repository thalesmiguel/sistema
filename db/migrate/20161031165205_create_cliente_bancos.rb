class CreateClienteBancos < ActiveRecord::Migration[5.0]
  def change
    create_table :cliente_bancos do |t|
      t.references :banco, foreign_key: true
      t.string :agencia
      t.string :conta_corrente
      t.references :cidade, foreign_key: true
      t.date :data_abertura_conta
      t.text :observacao
      t.string :correntista_nome
      t.string :correntista_cpf_cnpj
      t.boolean :primario
      t.boolean :ativo
      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
