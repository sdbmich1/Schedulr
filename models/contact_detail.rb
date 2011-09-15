class ContactDetail < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true
end
