class AddPaymentToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :payment, :boolean, null: false, default: false
  end
end
