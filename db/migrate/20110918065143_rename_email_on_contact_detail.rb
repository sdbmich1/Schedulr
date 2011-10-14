class RenameEmailOnContactDetail < ActiveRecord::Migration
  def self.up
    rename_column :contact_details, :email, :email_address
  end

  def self.down
  end
end
