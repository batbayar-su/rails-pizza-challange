require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:pizza) { Product.create({ name: 'Margherita', group: 'pizza', price: 500, price_scale: DEFAULT_SCALE }) }
  let(:size) { ProductSize.create({ name: 'Medium', multiplier: 100, multiplier_scale: DEFAULT_SCALE }) }
  let(:extra) { Ingredient.create({ name: 'Onions', price: 100, price_scale: DEFAULT_SCALE }) }
  let(:order) { OrderBuilder.build([{ product: pizza, product_size: size, adds: [extra], removes: [extra] }]) }

  describe 'GET /index' do
    it 'should render no open order message' do
      get '/orders'
      expect(response.body).to include('There is no open order')
    end

    it 'should render open orders' do
      order.save
      get '/orders'
      expect(response.body).not_to include('There is no open order')
    end

    it 'should update order' do
      order.save
      headers = { 'ACCEPT' => 'application/json' }
      params = { order: { state: Order::COMPLETED } }
      put "/orders/#{order.id}", params: params, headers: headers
      expect(response.body).to include('Successfully updated')
    end
  end
end
