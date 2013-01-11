class ChangeTransactionTable < ActiveRecord::Migration
  def self.up
    change_column :transactions, :confirmation_no, :string
    add_column :transactions, :token, :string
  end

  def self.down
  end
end
