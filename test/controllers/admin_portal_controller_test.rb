require "test_helper"

class AdminPortalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_portal_index_url
    assert_response :success
  end
end
