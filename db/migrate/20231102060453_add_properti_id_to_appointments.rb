class AddPropertiIdToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :property_id, :integer
  end
end
