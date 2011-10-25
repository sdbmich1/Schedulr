class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.string :code
      t.string :description
      t.integer :amt
      t.string :currency
      t.datetime :transaction_date
      t.string :channelID
      t.string :HostProfileID
      t.integer :user_id
      t.string :status
      t.string :hide
      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
