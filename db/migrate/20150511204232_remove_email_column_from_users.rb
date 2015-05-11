class RemoveEmailColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email
    add_index :users, :name, unique: true
  end
end
