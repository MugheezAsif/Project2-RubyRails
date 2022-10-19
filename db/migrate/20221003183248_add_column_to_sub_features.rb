class AddColumnToSubFeatures < ActiveRecord::Migration[7.0]
  def change
    add_column :sub_features, :unit_price, :integer
  end
end
