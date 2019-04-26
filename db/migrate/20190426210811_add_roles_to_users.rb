class AddRolesToUsers < ActiveRecord::Migration[5.2]
  def change
    # Default Users to role: user
    add_column :users, :roles, :string, default: :user
  end
end
