class RenameTypeToUserTypeInDevise < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :type, :user_type
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
