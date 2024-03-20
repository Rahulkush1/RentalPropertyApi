class ChangeFlatTypeToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :flat_details, :flat_type, :integer
  end
end
