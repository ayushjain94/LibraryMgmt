json.extract! student, :id, :name, :email, :password, :degree_to_book_mappings_id, :university, :fine_due, :is_active, :created_at, :updated_at
json.url student_url(student, format: :json)
