class Order < ApplicationRecord
  OPEN = 'open'.freeze
  COMPLETED = 'completed'.freeze
  CANCELED = 'canceled'.freeze

  enum state: { open: OPEN, completed: COMPLETED, canceled: CANCELED }
  has_many :order_items
  has_and_belongs_to_many :promotions, class_name: 'Deal', join_table: :deals_orders, foreign_key: :order_id,
                                       association_foreign_key: :deal_id
  belongs_to :discount, class_name: 'Deal', foreign_key: 'discount_id', optional: true

  def total_float
    (total / (10**total_scale).to_f).round(total_scale)
  end

  def calculate_total
    total_cents = order_items.map(&:calculate_price).reduce(:+)
    promo_deduction = calculate_promotions
    total_cents -= promo_deduction
    discount_deduction = calculate_discount(total_cents)

    self.total = total_cents - discount_deduction
    self.total_scale = DEFAULT_SCALE
  end

  def calculate_promotions
    deduction = 0
    if promotions.present?
      promotions.each do |promotion|
        next unless promotion.promo?

        items = order_items.filter do |item|
          item.item_id == promotion.product.id && item.variant_id == promotion.product_size.id
        end

        free = promotion.from - promotion.to
        free_total = items.count / promotion.from * free
        deduction = items[0].calculate_item_price * free_total
      end
    end
    deduction
  end

  def calculate_discount(total_cents)
    deduction = 0
    if discount.present?
      if discount.percent?
        deduction = (total_cents * discount.discount_percentage).round
      elsif discount.absolut?
        deduction = discount.value
      end
    end
    deduction
  end
end
