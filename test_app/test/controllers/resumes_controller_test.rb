require 'test_helper'

class ResumesControllerTest < ActionDispatch::IntegrationTest
  test "should get indesx" do
    get resumes_indesx_url
    assert_response :success
  end

  test "should get new" do
    get resumes_new_url
    assert_response :success
  end

  test "should get create" do
    get resumes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get resumes_destroy_url
    assert_response :success
  end

end
