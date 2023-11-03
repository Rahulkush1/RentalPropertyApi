require "test_helper"

class Api::V1::Users::RegisterationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_users_registerations_create_url
    assert_response :success
  end
end
