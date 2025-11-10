modele CurrentCart
    private

        def set_cart
                @cart = Cart.find(session[:cart_id])
        rescue ActiveRecord::RecordNotFound
                @cart = Cart.create
                session[:cart_id] = @cart.index
        end
    
end
