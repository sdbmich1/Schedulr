class CreateInterests < ActiveRecord::Migration
  def self.up
    create_table :interests do |t|
      t.string :code
      t.string :description
      t.string :status
      t.string :hide
      t.integer :sortkey

      t.timestamps
    end
  end

  def self.down
    drop_table :interests
  end
end
