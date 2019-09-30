json.extract! book_audit, :id, :isbn, :title, :author, :is_available, :language, :publish_date, :edition, :image, :subject, :summary, :is_special, :book_id, :is_active, :issued_date, :returned_date, :student_id, :created_at, :updated_at
json.url book_audit_url(book_audit, format: :json)
