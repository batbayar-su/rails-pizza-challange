require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject do
    described_class.new(item_name: 'Test Item',
                        variant_name: 'Small',
                        price: 500,
                        price_scale: 2,
                        multiplier: 70,
                        multiplier_scale: 2)
  end

  describe 'multiplier_percentage' do
    it 'should return multiplier as percentage' do
      expect(subject.multiplier_percentage).to equal(0.7)
    end
  end

  describe 'calculate_item_price' do
    it 'should return multiplied price by multiplier' do
      expect(subject.calculate_item_price).to equal(350.0)
    end
  end

  describe 'calculate_price' do
    it 'should return multiplied price by multiplier when there is no extra' do
      expect(subject.calculate_price).to equal(350.0)
    end

    it 'should return multiplied price with multiplied extra price' do
      extra = OrderItemExtra.new(group: OrderItemExtra::ADD,
                                 name: 'Test item extra',
                                 price: 110,
                                 price_scale: 2)
      subject.order_item_extras = [extra]
      expect(subject.calculate_price).to equal(427.0)
    end
  end
end
