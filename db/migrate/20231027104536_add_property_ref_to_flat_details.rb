class AddPropertyRefToFlatDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :flat_details, :property, null: false, foreign_key: true
  end
end
