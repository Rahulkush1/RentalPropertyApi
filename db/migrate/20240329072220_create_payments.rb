class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :payment_intent_id
      t.integer :user_id
      t.datetime :paid_At
      t.float :property_price
      t.float :tax_price
      t.float :total_price
      t.string :payment_status
      t.integer :booking_id

      t.timestamps
    end
  end
end
