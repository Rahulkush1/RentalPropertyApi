class RenameFirstNameToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :firts_name, :first_name
  end
end
