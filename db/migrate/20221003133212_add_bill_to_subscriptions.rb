class AddBillToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :bill, :integer
  end
end
