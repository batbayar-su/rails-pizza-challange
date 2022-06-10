require 'rails_helper'

RSpec.describe Order, type: :model do
  salami = Product.new({ id: 1, name: 'Salami', group: 'pizza', price: 500, price_scale: DEFAULT_SCALE })
  small = ProductSize.new({ id: 1, name: 'Small', multiplier: 70, multiplier_scale: DEFAULT_SCALE })
  promo = Deal.new({ name: 'Salami (small) 2 for 1 promotion', code: '2FOR1', group: 'promo', product: salami,
                     product_size: small, from: 2, to: 1 })
  discount = Deal.new({ name: 'Save 5% in limited time', code: 'SAVE5', group: 'percent', value: 5,
                        value_scale: DEFAULT_SCALE })
  order_item = OrderItem.new({ item_id: salami.id, item_name: salami.name, variant_id: small.id,
                               variant_name: small.name, price: salami.price, price_scale: DEFAULT_SCALE,
                               multiplier: small.multiplier, multiplier_scale: DEFAULT_SCALE })

  subject do
    order_items = [order_item.clone, order_item.clone]
    described_class.new({ order_items:, state: Order::OPEN })
  end

  describe 'calculate_total' do
    it 'should return sum of items price when there is no discount' do
      subject.calculate_total
      expect(subject.total).to equal(700)
    end

    it 'should return sum of items price with reduced via promotion' do
      subject.promotions = [promo]
      subject.calculate_total
      expect(subject.total).to equal(350)
    end

    it 'should return sum of items price with reduced via discount' do
      subject.discount = discount
      subject.calculate_total
      expect(subject.total).to equal(665)
    end
  end

  describe 'total_float' do
    it 'should return scaled total' do
      subject.calculate_total
      expect(subject.total_float).to equal(7.0)
    end
  end
end
