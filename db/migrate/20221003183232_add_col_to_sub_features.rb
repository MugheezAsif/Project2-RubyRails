class AddColToSubFeatures < ActiveRecord::Migration[7.0]
  def change
    add_column :sub_features, :name, :string
  end
end
