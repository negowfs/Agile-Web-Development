require "test_helper"

class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[ create ]
  before_action :set_line_item, only: %i[ show edit update destroy ]

  # GET /line_items
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.turbo_stream do
          @current_item = @line_item
        end
        format.html { redirect_to @line_item.cart }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  def destroy
    cart = @line_item.cart
    @line_item.destroy!

    respond_to do |format|
      format.html { redirect_to cart, status: :see_other, notice: "Line item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.expect(line_item: [ :product_id ])
    end
end
