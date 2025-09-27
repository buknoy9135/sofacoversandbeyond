require "test_helper"

class QuoteRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get quote_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get quote_requests_create_url
    assert_response :success
  end
end
