margherita, salami, tonno = Product.create([{ name: 'Margherita', group: 'pizza', price: 500, price_scale: DEFAULT_SCALE },
                                            { name: 'Salami', group: 'pizza', price: 600, price_scale: DEFAULT_SCALE },
                                            { name: 'Tonno', group: 'pizza', price: 800, price_scale: DEFAULT_SCALE }])

small, medium, large = ProductSize.create([{ name: 'Small', multiplier: 70, multiplier_scale: DEFAULT_SCALE },
                                           { name: 'Medium', multiplier: 100, multiplier_scale: DEFAULT_SCALE },
                                           { name: 'Large', multiplier: 130, multiplier_scale: DEFAULT_SCALE }])

onions, cheese, olives = Ingredient.create([{ name: 'Onions', price: 100, price_scale: DEFAULT_SCALE },
                                            { name: 'Cheese', price: 200, price_scale: DEFAULT_SCALE },
                                            { name: 'Olives', price: 250, price_scale: DEFAULT_SCALE }])

promo, discount = Deal.create([
                                {
                                  name: 'Salami (small) 2 for 1 promotion',
                                  code: '2FOR1',
                                  group: 'promo',
                                  product: salami,
                                  product_size: small,
                                  from: 2,
                                  to: 1
                                }, {
                                  name: 'Save 5% in limited time',
                                  code: 'SAVE5',
                                  group: 'percent',
                                  value: 5,
                                  value_scale: DEFAULT_SCALE
                                }
                              ])

OrderBuilder.new.build([{ product: tonno, product_size: large }]).save
OrderBuilder.new.build([
                         { product: margherita, product_size: large, adds: [onions, cheese, olives] },
                         { product: tonno, product_size: medium, removes: [onions, olives] },
                         { product: margherita, product_size: small }
                       ]).save
OrderBuilder.new.build([
                         { product: salami, product_size: medium, adds: [onions], removes: [cheese] },
                         { product: salami, product_size: small },
                         { product: salami, product_size: small },
                         { product: salami, product_size: small },
                         { product: salami, product_size: small, adds: [olives] }
                       ],
                       [promo],
                       discount).save
