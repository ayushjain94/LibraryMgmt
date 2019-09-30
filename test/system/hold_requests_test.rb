require "application_system_test_case"

class HoldRequestsTest < ApplicationSystemTestCase
  setup do
    @hold_request = hold_requests(:one)
  end

  test "visiting the index" do
    visit hold_requests_url
    assert_selector "h1", text: "Hold Requests"
  end

  test "creating a Hold request" do
    visit hold_requests_url
    click_on "New Hold Request"

    fill_in "Book", with: @hold_request.book_id
    fill_in "Day count", with: @hold_request.day_count
    check "Is approved" if @hold_request.is_approved
    fill_in "Student", with: @hold_request.student_id
    click_on "Create Hold request"

    assert_text "Hold request was successfully created"
    click_on "Back"
  end

  test "updating a Hold request" do
    visit hold_requests_url
    click_on "Edit", match: :first

    fill_in "Book", with: @hold_request.book_id
    fill_in "Day count", with: @hold_request.day_count
    check "Is approved" if @hold_request.is_approved
    fill_in "Student", with: @hold_request.student_id
    click_on "Update Hold request"

    assert_text "Hold request was successfully updated"
    click_on "Back"
  end

  test "destroying a Hold request" do
    visit hold_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Hold request was successfully destroyed"
  end
end
