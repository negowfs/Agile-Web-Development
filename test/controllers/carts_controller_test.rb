class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show destroy ]

  def index
    @carts = Cart.all
  end

  def show
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to store_index_url, notice: "Your cart is currently empty" }
      format.json { head :no_content }
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
