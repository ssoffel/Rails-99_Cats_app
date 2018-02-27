class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|
      t.string :birth_date, null: false
      t.string :color, null: false
      t.string :name, null: false
      t.string :sex, limit: 5, null: false
      t.text :description
      t.timestamps
    end

   add_index :cats, :name
  end
end
