class RemoveColumnFromSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :total_usage, :string
  end
end
