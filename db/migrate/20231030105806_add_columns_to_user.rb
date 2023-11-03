class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :activated, :boolean, default: false
    add_column :users, :confirmed_at, :datetime
  end
end
