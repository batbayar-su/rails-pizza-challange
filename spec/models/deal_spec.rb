require 'rails_helper'

RSpec.describe Deal, type: :model do
  subject do
    described_class.new(name: 'Save 15%',
                        code: 'SAVE15',
                        group: Deal::PERCENT,
                        value: 15,
                        value_scale: 2)
  end

  describe 'discount_percentage' do
    it 'should return deal value as percentage when deal is percent' do
      expect(subject.discount_percentage).to equal(0.15)
    end

    it 'should return nil when deal is not percent' do
      promo = described_class.new(name: 'Salami (small) 2 for 1 promotion',
                                  code: '2FOR1',
                                  group: 'promo',
                                  from: 2,
                                  to: 1)
      expect(promo.discount_percentage).to equal(nil)
    end
  end
end
