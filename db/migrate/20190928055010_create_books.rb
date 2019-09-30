class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.boolean :is_available
      t.string :language
      t.date :publish_date
      t.string :edition
      t.string :image
      t.string :subject
      t.string :summary
      t.boolean :is_special
      t.boolean :is_active
      t.integer :count
      t.references :library, null: false, foreign_key: true

      t.timestamps
    end
  end
end
