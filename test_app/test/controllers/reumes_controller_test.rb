require 'test_helper'

class ReumesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reumes_index_url
    assert_response :success
  end

  test "should get new" do
    get reumes_new_url
    assert_response :success
  end

  test "should get create" do
    get reumes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get reumes_destroy_url
    assert_response :success
  end

end
