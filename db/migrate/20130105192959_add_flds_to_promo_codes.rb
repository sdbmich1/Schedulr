class AddFldsToPromoCodes < ActiveRecord::Migration
  def self.up
    add_column :promo_codes, :status, :string
    add_column :promo_codes, :max_redemptions, :integer
    add_column :promo_codes, :amountOff, :integer
    add_column :promo_codes, :percentOff, :integer
    add_column :promo_codes, :currency, :string
  end

  def self.down
    remove_column :promo_codes, :currency
    remove_column :promo_codes, :percentOff
    remove_column :promo_codes, :amountOff
    remove_column :promo_codes, :max_redemptions
    remove_column :promo_codes, :status
  end
end
