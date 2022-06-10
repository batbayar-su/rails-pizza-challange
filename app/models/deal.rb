class Deal < ApplicationRecord
  PROMO = 'promo'.freeze
  PERCENT = 'percent'.freeze
  ABSOLUTE = 'absolute'.freeze

  enum group: { promo: PROMO, percent: PERCENT, absolute: ABSOLUTE }
  belongs_to :product, optional: true
  belongs_to :product_size, optional: true

  def discount_percentage
    (value / (10**value_scale).to_f).round(value_scale) if group === PERCENT
  end
end
