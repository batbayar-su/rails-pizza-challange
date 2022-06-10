require 'rails_helper'

RSpec.describe OrderItemExtra, type: :model do
  subject do
    described_class.new(group: OrderItemExtra::ADD,
                        name: 'Test item extra',
                        price: 110,
                        price_scale: 2)
  end

  describe 'calculate_price' do
    it 'should return multiplied price by multiplier' do
      expect(subject.calculate_price(0.3)).to equal(33)
    end

    it 'should return multiplied, rounded price when result is float' do
      expect(subject.calculate_price(0.33)).to equal(36)
    end

    it 'should return nil when multiplier is nil' do
      expect(subject.calculate_price(nil)).to equal(nil)
    end
  end
end
