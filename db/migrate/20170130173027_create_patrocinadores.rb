class CreatePatrocinadores < ActiveRecord::Migration[5.0]
  def change
    create_table :patrocinadores do |t|
      t.string :nome
      t.attachment :logo

      t.timestamps
    end
  end
end
