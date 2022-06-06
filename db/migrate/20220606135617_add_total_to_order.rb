class AddTotalToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :total, :integer
    add_column :orders, :total_scale, :integer
  end
end
