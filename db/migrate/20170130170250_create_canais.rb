class CreateCanais < ActiveRecord::Migration[5.0]
  def change
    create_table :canais do |t|
      t.string :nome
      t.text :observacao
      t.text :inf_transmissao
      t.attachment :logo

      t.timestamps
    end
  end
end
