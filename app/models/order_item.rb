class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item, class_name: 'Product', foreign_key: 'item_id'
  belongs_to :variant, class_name: 'ProductSize', foreign_key: 'variant_id'
  has_many :order_item_extras

  def multiplier_percentage
    (multiplier / (10**multiplier_scale).to_f).round(multiplier_scale)
  end

  def calculate_item_price
    price * multiplier_percentage
  end

  def calculate_price
    extra_cents = order_item_extras.map { |extra| extra.calculate_price(multiplier_percentage) }.reduce(:+) || 0
    price * multiplier_percentage + extra_cents
  end
end
