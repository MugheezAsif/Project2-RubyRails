class RemoveColFromSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :usage, :string
  end
end
