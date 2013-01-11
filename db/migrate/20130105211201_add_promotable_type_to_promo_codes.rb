class AddPromotableTypeToPromoCodes < ActiveRecord::Migration
  def self.up
    add_column :promo_codes, :promoable_type, :string
  end

  def self.down
    remove_column :promo_codes, :promoable_type
  end
end
