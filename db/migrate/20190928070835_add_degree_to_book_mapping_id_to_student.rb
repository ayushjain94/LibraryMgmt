class AddDegreeToBookMappingIdToStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :degree_to_book_mappings, null: true, foreign_key: true
  end
end
