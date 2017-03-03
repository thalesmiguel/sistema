class DeviseAlterUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nome, :string, null: false, default: ""
  end
end
