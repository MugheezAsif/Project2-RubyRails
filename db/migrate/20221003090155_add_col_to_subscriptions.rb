class AddColToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :total_usage, :integer
  end
end
