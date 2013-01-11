class ChangeTransactionAmt < ActiveRecord::Migration
  def self.up
    change_column :transactions, :amt, :float
  end

  def self.down
  end
end
