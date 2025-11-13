class ApplicationController < ActionController::Base
  before_action :set_cart

  private

  def set_cart
    @cart = current_cart
  end

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
