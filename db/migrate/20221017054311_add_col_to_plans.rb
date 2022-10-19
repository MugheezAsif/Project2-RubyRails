class AddColToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :stripe_plan_id, :string
  end
end
