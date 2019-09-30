class CreateDegreeToBookMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :degree_to_book_mappings do |t|
      t.string :educational_level
      t.integer :book_count

      t.timestamps
    end
  end
end
