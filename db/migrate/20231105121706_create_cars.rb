class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.integer :seats
      t.string :brand
      t.string :model
      t.decimal :price, precision: 8, scale: 2
      t.timestamps
    end
  end
end
