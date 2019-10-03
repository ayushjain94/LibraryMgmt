class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.references :student, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :issued_from
      t.float :fine
      t.date :due_date

      t.timestamps
    end
  end
end
