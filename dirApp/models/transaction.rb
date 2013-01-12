class Transaction < ActiveRecord::Base
  has_many :transaction_details

  attr_accessible :code, :description, :amt, :currency, :transaction_date, :channelID, :HostProfileID, :user_id, :status, :hide
end
