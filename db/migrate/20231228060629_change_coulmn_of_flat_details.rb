class ChangeCoulmnOfFlatDetails < ActiveRecord::Migration[7.0]
  def change
    change_table :flat_details do |t|
      t.change :flat_type, :integer
    end
  end
end
