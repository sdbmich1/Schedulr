class Picture < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  has_attached_file :photo

  validates_attachment_presence :photo  
  validates_attachment_size :photo, :less_than => 2.megabytes  
end
