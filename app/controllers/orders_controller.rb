class OrdersController < ApplicationController
  def index
    @orders = Order.open
    @message = params[:message]
  end

  def update
    @order = Order.find(params[:id])
    if @order.update!(order_params)
      render json: { message: 'Successfully updated' }
    else
      render json: { message: 'Failed to update' }
    end
  end

  private

  def order_params
    params.require(:order).permit(:state)
  end
end
