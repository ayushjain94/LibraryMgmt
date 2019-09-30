require 'test_helper'

class DegreeToBookMappingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @degree_to_book_mapping = degree_to_book_mappings(:one)
  end

  test "should get index" do
    get degree_to_book_mappings_url
    assert_response :success
  end

  test "should get new" do
    get new_degree_to_book_mapping_url
    assert_response :success
  end

  test "should create degree_to_book_mapping" do
    assert_difference('DegreeToBookMapping.count') do
      post degree_to_book_mappings_url, params: { degree_to_book_mapping: { book_count: @degree_to_book_mapping.book_count, educational_level: @degree_to_book_mapping.educational_level } }
    end

    assert_redirected_to degree_to_book_mapping_url(DegreeToBookMapping.last)
  end

  test "should show degree_to_book_mapping" do
    get degree_to_book_mapping_url(@degree_to_book_mapping)
    assert_response :success
  end

  test "should get edit" do
    get edit_degree_to_book_mapping_url(@degree_to_book_mapping)
    assert_response :success
  end

  test "should update degree_to_book_mapping" do
    patch degree_to_book_mapping_url(@degree_to_book_mapping), params: { degree_to_book_mapping: { book_count: @degree_to_book_mapping.book_count, educational_level: @degree_to_book_mapping.educational_level } }
    assert_redirected_to degree_to_book_mapping_url(@degree_to_book_mapping)
  end

  test "should destroy degree_to_book_mapping" do
    assert_difference('DegreeToBookMapping.count', -1) do
      delete degree_to_book_mapping_url(@degree_to_book_mapping)
    end

    assert_redirected_to degree_to_book_mappings_url
  end
end
