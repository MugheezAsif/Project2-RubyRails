class CreateSubFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_features do |t|
      t.references :subscription, null: false, foreign_key: true
      t.integer :current_usage, default: '0'
      t.integer :max_usage
      t.integer :bill

      t.timestamps
    end
  end
end
