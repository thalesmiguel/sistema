class CreateSubtipos < ActiveRecord::Migration[5.0]
  def change
    create_table :subtipos do |t|
      t.string :codigo
      t.string :nome

      t.timestamps
    end
  end
end
