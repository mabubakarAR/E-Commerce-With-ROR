class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.decimal :price
      t.string :picture

      t.timestamps
    end
  end
end
