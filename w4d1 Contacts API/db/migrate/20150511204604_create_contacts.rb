class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :contacts, :user_id
  end
end
