require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    login_as users(:one)
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    cart = carts(:one)
    product = products(:one)
    cart.line_items.create(product: product)

    post orders_url, params: {
      order: {
        name: "Test User",
        address: "123 Test St",
        email: "test@example.com",
        pay_type: "Check"
      }
    }

    assert_redirected_to store_index_url
    follow_redirect!

    assert_equal 0, cart.reload.line_items.size
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should destroy order" do
    assert_difference("Order.count", -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
