require "test_helper"

class BuyerPortalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get buyer_portal_index_url
    assert_response :success
  end
end
