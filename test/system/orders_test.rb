require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  test "check dynamic fields" do
    visit store_index_url
    click_on "Add to Cart", match: :first
    first(:link_or_button, "Checkout").click

    assert has_no_field? "Routing number"
    assert has_no_field? "Account number"
    assert has_no_field? "Credit card number"
    assert has_no_field? "Expiration date"
    assert has_no_field? "PO number"

    select "Check", from: "Pay type"

    assert has_field? "Routing number"
    assert has_field? "Account number"
    assert has_no_field? "Credit card number"
    assert has_no_field? "Expiration date"
    assert has_no_field? "PO number"

    select "Credit Card", from: "Pay type"

    assert has_no_field? "Routing number"
    assert has_no_field? "Account number"
    assert has_field? "Credit card number"
    assert has_field? "Expiration date"
    assert has_no_field? "PO number"

    select "Purchase Order", from: "Pay type"

    assert has_no_field? "Routing number"
    assert has_no_field? "Account number"
    assert has_no_field? "Credit card number"
    assert has_no_field? "Expiration date"
    assert has_field? "Po number"
  end

  test "check order and delivery" do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    click_on "Add to Cart", match: :first

    first(:link_or_button, "Checkout").click

    fill_in "Name", with: "Weverson Ferreira"
    fill_in "Address", with: "Judas Perdeu as Botas"
    fill_in "Email", with: "wfs@example.com"

    select "Check", from: "Pay type"
    fill_in "Routing number", with: "123456"
    fill_in "Account number", with: "987654"

    save_page
    puts page.html

    click_button "Place Order"
    assert_text "Thank you for your order"

    perform_enqueued_jobs
    perform_enqueued_jobs
    assert_performed_jobs 2

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first
    assert_equal "Weverson Ferreira", order.name
    assert_equal "Judas Perdeu as Botas", order.address
    assert_equal "wfs@example.com", order.email
    assert_equal "check", order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal [ "wfs@example.com" ], mail.to
    assert_equal "Sam Ruby <depot@example.com>", mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end
end
