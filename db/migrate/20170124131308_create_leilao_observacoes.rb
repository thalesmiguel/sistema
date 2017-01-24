class CreateLeilaoObservacoes < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_observacoes do |t|
      t.text :descricao
      t.references :user, foreign_key: true
      t.boolean :ativo
      t.references :leilao, foreign_key: true

      t.timestamps
    end
  end
end
