class CreateClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :claims do |t|
      t.string  :user_state
      t.string  :admin_state
      t.json     :updates, default: []
      t.json     :details
      t.json     :price

      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
