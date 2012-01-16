class PromoCode < ActiveRecord::Base
  belongs_to :promoable, :polymorphic => true
end
