class CartItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @cart_items = current_user.cart_items.includes(:product)
    @total_amount = calculate_total_amount
  end

  def create
    @cart_item = current_user.cart_items.build(product_id: params[:product_id])

    if @cart_item.save
      redirect_to root_path, notice: 'Product added to cart.'
    else
      redirect_to root_path, alert: 'Failed to add product to cart.'
    end
  end

  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  private

  def calculate_total_amount
    current_user.cart_items.includes(:product).sum { |cart_item| cart_item.product.price }
  end
end