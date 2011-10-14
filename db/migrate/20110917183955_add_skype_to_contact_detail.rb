class AddSkypeToContactDetail < ActiveRecord::Migration
  def self.up
    add_column :contact_details, :skype, :string
  end

  def self.down
    remove_column :contact_details, :skype
  end
end
