class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.string :email
      t.string :contato
      t.boolean :mala_direta, default: true
      t.boolean :solicitacao_email, default: true
      t.boolean :envio_contratos, default: true
      t.boolean :ativo, default: true
      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
