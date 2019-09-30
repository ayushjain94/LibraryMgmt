class CreateBookAudits < ActiveRecord::Migration[6.0]
  def change
    create_table :book_audits do |t|
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
      t.references :book, null: false, foreign_key: true
      t.boolean :is_active
      t.date :issued_date
      t.date :returned_date
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
