require "application_system_test_case"

class BookAuditsTest < ApplicationSystemTestCase
  setup do
    @book_audit = book_audits(:one)
  end

  test "visiting the index" do
    visit book_audits_url
    assert_selector "h1", text: "Book Audits"
  end

  test "creating a Book audit" do
    visit book_audits_url
    click_on "New Book Audit"

    fill_in "Author", with: @book_audit.author
    fill_in "Book", with: @book_audit.book_id
    fill_in "Edition", with: @book_audit.edition
    fill_in "Image", with: @book_audit.image
    check "Is active" if @book_audit.is_active
    check "Is available" if @book_audit.is_available
    check "Is special" if @book_audit.is_special
    fill_in "Isbn", with: @book_audit.isbn
    fill_in "Issued date", with: @book_audit.issued_date
    fill_in "Language", with: @book_audit.language
    fill_in "Publish date", with: @book_audit.publish_date
    fill_in "Returned date", with: @book_audit.returned_date
    fill_in "Student", with: @book_audit.student_id
    fill_in "Subject", with: @book_audit.subject
    fill_in "Summary", with: @book_audit.summary
    fill_in "Title", with: @book_audit.title
    click_on "Create Book audit"

    assert_text "Book audit was successfully created"
    click_on "Back"
  end

  test "updating a Book audit" do
    visit book_audits_url
    click_on "Edit", match: :first

    fill_in "Author", with: @book_audit.author
    fill_in "Book", with: @book_audit.book_id
    fill_in "Edition", with: @book_audit.edition
    fill_in "Image", with: @book_audit.image
    check "Is active" if @book_audit.is_active
    check "Is available" if @book_audit.is_available
    check "Is special" if @book_audit.is_special
    fill_in "Isbn", with: @book_audit.isbn
    fill_in "Issued date", with: @book_audit.issued_date
    fill_in "Language", with: @book_audit.language
    fill_in "Publish date", with: @book_audit.publish_date
    fill_in "Returned date", with: @book_audit.returned_date
    fill_in "Student", with: @book_audit.student_id
    fill_in "Subject", with: @book_audit.subject
    fill_in "Summary", with: @book_audit.summary
    fill_in "Title", with: @book_audit.title
    click_on "Update Book audit"

    assert_text "Book audit was successfully updated"
    click_on "Back"
  end

  test "destroying a Book audit" do
    visit book_audits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Book audit was successfully destroyed"
  end
end
