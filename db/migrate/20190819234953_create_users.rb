class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :phone_number
      t.string :auth_token

      t.timestamps
    end
    add_index :users, :phone_number, unique: true
    add_index :users, :auth_token, unique: true
  end
end
