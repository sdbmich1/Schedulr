class CreatePromoCodes < ActiveRecord::Migration
  def self.up
    create_table :promo_codes do |t|
      t.string :code
      t.string :promo_name
      t.text :description
      t.datetime :promostartdate
      t.datetime :promoenddate
      t.datetime :promostarttime
      t.datetime :promoendtime
      t.references :promoable
      t.string :LastUpdatedBy

      t.timestamps
    end
  end

  def self.down
    drop_table :promo_codes
  end
end
