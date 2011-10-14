class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :mapcity
      t.string :mapstreet
      t.string :mapstate
      t.string :mapzip
      t.string :mapplacename
      t.string :work_phone
      t.string :home_phone
      t.string :mobile_phone
      t.string :work_email
      t.string :email
      t.string :facebook_name
      t.string :twitter_name
      t.string :linkedin_name
      t.references :contactable, :polymorphic

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
