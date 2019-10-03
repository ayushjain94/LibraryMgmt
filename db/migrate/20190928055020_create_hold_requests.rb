class CreateHoldRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :hold_requests do |t|
      t.references :book, null: false, foreign_key: true, references: :book
      t.references :student, null: false, foreign_key: true, references: :student
      t.boolean :is_approved
      t.integer :day_count

      t.timestamps
    end
  end
end