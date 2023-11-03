class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :address_line
      t.string :street
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
