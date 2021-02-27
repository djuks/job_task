class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: :show

  def index
    orders = Order.where(user_id: params[:user_id])

    authorize orders

    render_json(orders, "OrderSerializer")
  end

  def show
    authorize @order

    render_json(@order, "OrderSerializer")
  end

  def create
    order = current_user.orders.new(order_params)
    authorize order
    order.save!

    render_json(order, "OrderSerializer")
  end

  private

  def find_product
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name)
  end
end
