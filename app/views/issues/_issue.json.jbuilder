json.extract! issue, :id, :student_id, :book_id, :issued_from, :fine, :due_date, :created_at, :updated_at
json.url issue_url(issue, format: :json)
