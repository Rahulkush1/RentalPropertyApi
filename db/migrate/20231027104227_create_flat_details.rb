class CreateFlatDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :flat_details do |t|
      t.string :area
      t.string :flat_type
      t.string :available_for
      
      t.timestamps
    end
  end
end
