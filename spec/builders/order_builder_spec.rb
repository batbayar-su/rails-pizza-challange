require 'rails_helper'

RSpec.describe OrderBuilder do
  subject do
    OrderBuilder
  end

  let(:pizza) { Product.create({ name: 'Margherita', group: 'pizza', price: 500, price_scale: DEFAULT_SCALE }) }
  let(:size) { ProductSize.create({ name: 'Medium', multiplier: 100, multiplier_scale: DEFAULT_SCALE }) }
  let(:extra) { Ingredient.create({ name: 'Onions', price: 100, price_scale: DEFAULT_SCALE }) }

  describe 'build' do
    it 'should successfully build an Order' do
      order = OrderBuilder.build([{ product: pizza, product_size: size, adds: [extra], removes: [extra] }])
      expect(order.class).to equal(Order)
      puts order
    end

    pending 'test methods being called'
  end
end
