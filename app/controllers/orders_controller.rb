class OrdersController < ApplicationController
  def index
    @total_amount = calculate_total_amount
  end

  def create
    @order = current_user.orders.build(total_amount: calculate_total_amount)

    if @order.save
      current_user.cart_items.destroy_all
      redirect_to root_path, notice: 'Order placed successfully.'
    else
      redirect_to cart_path, alert: 'Failed to place the order.'
    end
  end

  private

  def calculate_total_amount
    current_user.cart_items.includes(:product).sum { |cart_item| cart_item.product.price }
  end
end
