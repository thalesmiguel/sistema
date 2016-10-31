class CreateBancos < ActiveRecord::Migration[5.0]
  def change
    create_table :bancos do |t|
      t.string :codigo
      t.string :nome

      t.timestamps
    end
  end
end
