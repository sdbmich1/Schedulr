class CreateStatusTypes < ActiveRecord::Migration
  def self.up
    create_table :status_types do |t|
      t.string :code
      t.string :description
      t.string :hide
      t.integer :sortkey

      t.timestamps
    end
  end

  def self.down
    drop_table :status_types
  end
end
