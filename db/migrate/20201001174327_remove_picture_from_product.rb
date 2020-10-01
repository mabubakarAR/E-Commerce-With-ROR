class RemovePictureFromProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :picture, :string
  end
end
