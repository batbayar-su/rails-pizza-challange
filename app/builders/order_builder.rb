class OrderBuilder
  # @param items [Array<Hash>] order item related objects included in order.
  # @option items [Product] :product
  # @option items [ProductSize] :product_size
  # @option items [Array<Ingredient>] :adds
  # @option items [Array<Ingredient>] :removes
  # @param promotions [Array<Deal>] promotion codes
  # @param discount [Deal] discount
  # @return [Order] has OrderItem(s) and OrderItemExtra(s) ready
  def self.build(items = [], promotions = [], discount = nil)
    order_items = build_items(items)
    order = Order.new({ promotions:, discount:, order_items:, state: Order::OPEN })
    order.calculate_total
    order
  end

  def self.build_items(items = [])
    items.map do |item|
      # multiplier_percentage = item[:product_size].multiplier_percentage

      adds = item[:adds] ? build_item_extras(item[:adds], OrderItemExtra::ADD) : []
      removes = item[:removes] ? build_item_extras(item[:removes], OrderItemExtra::REMOVE) : []
      extras = Array(adds) + Array(removes)

      build_item(item, extras)
    end
  end

  def self.build_item(item, order_item_extras)
    OrderItem.new({ order_item_extras:,
                    item: item[:product],
                    item_name: item[:product].name,
                    variant: item[:product_size],
                    variant_name: item[:product_size].name,
                    price: item[:product].price,
                    price_scale: item[:product].price_scale,
                    multiplier: item[:product_size].multiplier,
                    multiplier_scale: item[:product_size].multiplier_scale })
  end

  def self.build_item_extras(extras, group)
    extras.map do |extra|
      price = group == OrderItemExtra::ADD ? extra.price : 0
      OrderItemExtra.new({
                           extra:,
                           group:,
                           name: extra.name,
                           price:,
                           price_scale: extra.price_scale
                         })
    end
  end
end
