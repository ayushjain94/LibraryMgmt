require 'test_helper'

class BookAuditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_audit = book_audits(:one)
  end

  test "should get index" do
    get book_audits_url
    assert_response :success
  end

  test "should get new" do
    get new_book_audit_url
    assert_response :success
  end

  test "should create book_audit" do
    assert_difference('BookAudit.count') do
      post book_audits_url, params: { book_audit: { author: @book_audit.author, book_id: @book_audit.book_id, edition: @book_audit.edition, image: @book_audit.image, is_active: @book_audit.is_active, is_available: @book_audit.is_available, is_special: @book_audit.is_special, isbn: @book_audit.isbn, issued_date: @book_audit.issued_date, language: @book_audit.language, publish_date: @book_audit.publish_date, returned_date: @book_audit.returned_date, student_id: @book_audit.student_id, subject: @book_audit.subject, summary: @book_audit.summary, title: @book_audit.title } }
    end

    assert_redirected_to book_audit_url(BookAudit.last)
  end

  test "should show book_audit" do
    get book_audit_url(@book_audit)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_audit_url(@book_audit)
    assert_response :success
  end

  test "should update book_audit" do
    patch book_audit_url(@book_audit), params: { book_audit: { author: @book_audit.author, book_id: @book_audit.book_id, edition: @book_audit.edition, image: @book_audit.image, is_active: @book_audit.is_active, is_available: @book_audit.is_available, is_special: @book_audit.is_special, isbn: @book_audit.isbn, issued_date: @book_audit.issued_date, language: @book_audit.language, publish_date: @book_audit.publish_date, returned_date: @book_audit.returned_date, student_id: @book_audit.student_id, subject: @book_audit.subject, summary: @book_audit.summary, title: @book_audit.title } }
    assert_redirected_to book_audit_url(@book_audit)
  end

  test "should destroy book_audit" do
    assert_difference('BookAudit.count', -1) do
      delete book_audit_url(@book_audit)
    end

    assert_redirected_to book_audits_url
  end
end
