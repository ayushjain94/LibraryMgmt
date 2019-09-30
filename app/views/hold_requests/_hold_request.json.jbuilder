json.extract! hold_request, :id, :book_id, :student_id, :is_approved, :day_count, :created_at, :updated_at
json.url hold_request_url(hold_request, format: :json)
