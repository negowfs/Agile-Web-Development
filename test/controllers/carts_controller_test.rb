require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
    login_as users(:one)
  end

  test "should show cart" do
    get cart_url(@cart)
    assert_response :success
  end

  test "should destroy cart" do
    post line_items_url, params: { product_id: products(:pragprog).id }
    @cart = Cart.find(session[:cart_id])

    assert_difference("Cart.count", -1) do
      delete cart_url(@cart)
    end

    assert_redirected_to store_index_url
  end
end
