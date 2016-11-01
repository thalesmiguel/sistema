class CreateLancarAutorizados < ActiveRecord::Migration[5.0]
  def change
    create_table :lancar_autorizados do |t|
      t.string :nome
      t.string :cpf
      t.string :observacao
      t.boolean :tem_procuracao
      t.boolean :ativo
      t.attachment :procuracao
      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
