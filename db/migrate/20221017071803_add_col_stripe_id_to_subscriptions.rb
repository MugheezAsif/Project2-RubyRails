class AddColStripeIdToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :stripe_id, :string
  end
end
