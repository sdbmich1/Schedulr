class CreateLogoTypes < ActiveRecord::Migration
  def self.up
    create_table :logo_types do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :logo_types
  end
end
