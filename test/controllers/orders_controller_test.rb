require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get orders_new_url
    assert_response :success
  end

  test "should get create" do
    get orders_create_url
    assert_response :success
  end

  test "should get user_orders" do
    get orders_user_orders_url
    assert_response :success
  end
end
