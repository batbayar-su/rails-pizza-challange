class DecommissionDealCodeUsageInOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :deals_orders do |t|
      t.belongs_to :deal
      t.belongs_to :order
    end
    remove_column :orders, :promotions, :string
    remove_column :orders, :discount, :string
    add_column :orders, :discount_id, :integer, references: :deals
  end
end
