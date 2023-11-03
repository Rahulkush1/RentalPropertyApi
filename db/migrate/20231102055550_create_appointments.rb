class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.datetime :date
      t.datetime :time
      t.belongs_to :user

      t.timestamps
    end
  end
end
