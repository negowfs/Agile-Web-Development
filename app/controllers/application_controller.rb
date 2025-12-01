class ApplicationController < ActionController::Base
  include Authentication
  include CurrentCart
  before_action :set_cart
end
