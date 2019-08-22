class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :access_level, :decimal, default: 0
    add_column :users, :referral_code, :string, unique: true
    add_column :users, :stat, :json, default: {}
  end
end
