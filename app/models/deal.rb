class Deal < ApplicationRecord
  enum group: { promo: 'promo', percent: 'percent', absolute: 'absolute' }
  belongs_to :product, optional: true
  belongs_to :product_size, optional: true
end
