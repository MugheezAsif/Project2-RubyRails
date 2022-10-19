class AddColStripePriceIdToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :stripe_price_id, :string
  end
end
