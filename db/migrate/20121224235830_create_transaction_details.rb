class CreateTransactionDetails < ActiveRecord::Migration
  def self.up
    create_table :transaction_details do |t|
      t.integer :transaction_id
      t.string :item_name
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end

  def self.down
    drop_table :transaction_details
  end
end
