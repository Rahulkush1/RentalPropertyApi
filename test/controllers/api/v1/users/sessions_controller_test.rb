require "test_helper"

class Api::V1::Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_users_sessions_create_url
    assert_response :success
  end
end
