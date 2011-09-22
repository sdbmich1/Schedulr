class ContactDetail < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true

  email_regex = /[\w-]+@([\w-]+\.)+[\w-]+/i

  validates :work_email, :format => email_regex, :unless => Proc.new { |a| a.work_email.blank? } 
end
