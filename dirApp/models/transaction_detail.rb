class TransactionDetail < ActiveRecord::Base
  belongs_to :transaction

  attr_accessible :item, :quantity, :price
end
