class CreatePresenters < ActiveRecord::Migration
  def self.up
    create_table :presenters do |t|
      t.string :name
      t.text :bio
      t.string :title
      t.string :org_name
      t.integer :event_id
      t.timestamps
    end
  end

  def self.down
    drop_table :presenters
  end
end
