require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
    login_as users(:one)
  end

  test "should create line_item" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:ruby).id }
  end


    assert_redirected_to cart_url(assigns(:cart))
  end

  test "should destroy line_item" do
    cart = @line_item.cart

    assert_difference("LineItem.count", -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to cart_url(cart)
  end
end
