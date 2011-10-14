class CreateGmtTimezones < ActiveRecord::Migration
  def self.up
    create_table :gmt_timezones do |t|
      t.float :offset

      t.timestamps
    end
  end

  def self.down
    drop_table :gmt_timezones
  end
end
