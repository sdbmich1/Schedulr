class Transaction < ActiveRecord::Base
  attr_accessible :code, :description, :amt, :currency, :transaction_date, :channelID, :HostProfileID, :user_id, :status, :hide
end
