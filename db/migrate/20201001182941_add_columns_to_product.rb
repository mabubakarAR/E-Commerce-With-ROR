class AddColumnsToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :is_approved, :boolean, default: false
    add_column :products, :is_favourite, :boolean, default: false
  end
end
