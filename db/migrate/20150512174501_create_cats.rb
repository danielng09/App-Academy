class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date, :null => false
      t.string :color, :null => false
      t.string :name, :null => false
      t.string :gender, :null => false
      t.text :description, :null => false

      t.timestamps
    end

    add_index :cats, [:birth_date, :color, :name, :gender]
  end
end
