class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :university
      t.text :location
      t.integer :max_borrow_count
      t.float :fine

      t.timestamps
    end
  end
end
