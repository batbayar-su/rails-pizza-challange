class OrderItemExtra < ApplicationRecord
  ADD = 'add'.freeze
  REMOVE = 'remove'.freeze

  enum group: { add: ADD, remove: REMOVE }
  belongs_to :order_item
  belongs_to :extra, class_name: 'Ingredient', foreign_key: 'extra_id'

  # @param miltiplier [float]
  def calculate_price(miltiplier)
    (price * miltiplier).round if miltiplier
  end
end
