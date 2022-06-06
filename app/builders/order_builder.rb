class OrderBuilder
  # def build(booking:, card_id: nil, token: nil)
  #   @booking = booking
  #   @card_id = card_id
  #   @token = token
  # end
  # @param items [Array<Hash>] order item related objects included in order.
  # @option items [Product] :product
  # @option items [ProductSize] :product_size
  # @option items [Array<Ingredient>] :adds
  # @option items [Array<Ingredient>] :removes
  # @param promotions [Array<Deal>] promotion codes
  # @param discount [Deal] discount
  # @return [Order] has OrderItem(s) and OrderItemExtra(s) ready
  def build(items = [], promotions = [], discount = nil)
    order_items = build_items(items)
    Order.new({ promotions:, discount:, order_items: })
  end

  def build_items(items = [])
    items.map do |item|
      multiplier_percentage = item[:product_size].multiplier_percentage

      adds = item[:adds] ? build_item_extras(item[:adds], 'add', multiplier_percentage) : []
      removes = item[:removes] ? build_item_extras(item[:removes], 'remove', multiplier_percentage) : []
      extras = Array(adds) + Array(removes)

      build_item(item, extras, multiplier_percentage)
    end
  end

  def build_item(item, order_item_extras, multiplier_percentage)
    OrderItem.new({ order_item_extras:,
                    item: item[:product],
                    item_name: item[:product].name,
                    variant: item[:product_size],
                    variant_name: item[:product_size].name,
                    price: (item[:product].price * multiplier_percentage).round,
                    price_scale: item[:product].price_scale,
                    multiplier: item[:product_size].multiplier,
                    multiplier_scale: item[:product_size].multiplier_scale })
  end

  def build_item_extras(extras, group, multiplier_percentage)
    extras.map do |extra|
      price = group == 'add' ? (extra.price * multiplier_percentage).round : 0
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
