class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
end

cart = Cart.find(...)
puts "This cart has #{cart.line_items.count} line items"
