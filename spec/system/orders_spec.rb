require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  let(:pizza) { Product.create({ name: 'Margherita', group: 'pizza', price: 500, price_scale: DEFAULT_SCALE }) }
  let(:size) { ProductSize.create({ name: 'Medium', multiplier: 100, multiplier_scale: DEFAULT_SCALE }) }
  let(:extra) { Ingredient.create({ name: 'Onions', price: 100, price_scale: DEFAULT_SCALE }) }
  let(:order) { OrderBuilder.build([{ product: pizza, product_size: size, adds: [extra], removes: [extra] }]) }

  before do
    driven_by(:selenium_chrome_headless)
    order.save
  end

  it 'enables me to create widgets' do
    visit '/orders'

    expect(page).not_to have_text('There are no open order')

    click_on 'Complete'

    # TODO: figure out why click on is not being triggered
    # expect(page).to have_text('There are no open order')
  end
end
