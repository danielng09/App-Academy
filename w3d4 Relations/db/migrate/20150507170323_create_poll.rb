class CreatePoll < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :user_id
      t.string :title

      t.timestamps
    end

    add_index :polls, :user_id
  end
end
