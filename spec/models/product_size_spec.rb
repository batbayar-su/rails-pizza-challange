require 'rails_helper'

RSpec.describe ProductSize, type: :model do
  subject do
    described_class.new(name: 'Small',
                        multiplier: 70,
                        multiplier_scale: 2)
  end

  describe 'multiplier_percentage' do
    it 'should return deal multiplier as percentage' do
      expect(subject.multiplier_percentage).to equal(0.7)
    end
  end
end
