require "application_system_test_case"

class DegreeToBookMappingsTest < ApplicationSystemTestCase
  setup do
    @degree_to_book_mapping = degree_to_book_mappings(:one)
  end

  test "visiting the index" do
    visit degree_to_book_mappings_url
    assert_selector "h1", text: "Degree To Book Mappings"
  end

  test "creating a Degree to book mapping" do
    visit degree_to_book_mappings_url
    click_on "New Degree To Book Mapping"

    fill_in "Book count", with: @degree_to_book_mapping.book_count
    fill_in "Educational level", with: @degree_to_book_mapping.educational_level
    click_on "Create Degree to book mapping"

    assert_text "Degree to book mapping was successfully created"
    click_on "Back"
  end

  test "updating a Degree to book mapping" do
    visit degree_to_book_mappings_url
    click_on "Edit", match: :first

    fill_in "Book count", with: @degree_to_book_mapping.book_count
    fill_in "Educational level", with: @degree_to_book_mapping.educational_level
    click_on "Update Degree to book mapping"

    assert_text "Degree to book mapping was successfully updated"
    click_on "Back"
  end

  test "destroying a Degree to book mapping" do
    visit degree_to_book_mappings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Degree to book mapping was successfully destroyed"
  end
end
