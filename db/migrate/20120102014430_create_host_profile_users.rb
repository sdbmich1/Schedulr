class CreateHostProfileUsers < ActiveRecord::Migration
  def self.up
    create_table :host_profile_users do |t|
      t.integer :user_id
      t.string :subscriptionsourceID
      t.string :access_type

      t.timestamps
    end
    add_index :host_profile_users, :user_id
    add_index :host_profile_users, :subscriptionsourceID
    add_index :host_profile_users, [:user_id, :subscriptionsourceID]
  end

  def self.down
    drop_table :host_profile_users
  end
end
