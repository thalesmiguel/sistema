class CreateBairros < ActiveRecord::Migration[5.0]
  def change
    create_table :bairros do |t|
      t.string :nome
      t.references :cidade, foreign_key: true

      t.timestamps
    end
  end
end
