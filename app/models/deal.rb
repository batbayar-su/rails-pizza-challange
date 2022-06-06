class Deal < ApplicationRecord
  enum group: { promo: 'promo', percent: 'percent', absolute: 'absolute' }
  belongs_to :product, optional: true
  belongs_to :product_size, optional: true

  def discount_percentage
    (value / (10**value_scale).to_f).round(value_scale)
  end
end
