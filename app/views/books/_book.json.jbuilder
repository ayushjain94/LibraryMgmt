json.extract! book, :id, :isbn, :title, :author, :is_available, :language, :publish_date, :edition, :image, :subject, :summary, :is_special, :library_id, :is_active, :count, :created_at, :updated_at
json.url book_url(book, format: :json)
