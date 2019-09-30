require "application_system_test_case"

class StudentsTest < ApplicationSystemTestCase
  setup do
    @student = students(:one)
  end

  test "visiting the index" do
    visit students_url
    assert_selector "h1", text: "Students"
  end

  test "creating a Student" do
    visit students_url
    click_on "New Student"

    fill_in "Degree to book mapping", with: @student.degree_to_book_mapping_id
    fill_in "Emai", with: @student.emai
    fill_in "Fine due", with: @student.fine_due
    check "Is active" if @student.is_active
    fill_in "Name", with: @student.name
    fill_in "Password", with: @student.password
    fill_in "University", with: @student.university
    click_on "Create Student"

    assert_text "Student was successfully created"
    click_on "Back"
  end

  test "updating a Student" do
    visit students_url
    click_on "Edit", match: :first

    fill_in "Degree to book mapping", with: @student.degree_to_book_mapping_id
    fill_in "Emai", with: @student.emai
    fill_in "Fine due", with: @student.fine_due
    check "Is active" if @student.is_active
    fill_in "Name", with: @student.name
    fill_in "Password", with: @student.password
    fill_in "University", with: @student.university
    click_on "Update Student"

    assert_text "Student was successfully updated"
    click_on "Back"
  end

  test "destroying a Student" do
    visit students_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Student was successfully destroyed"
  end
end
