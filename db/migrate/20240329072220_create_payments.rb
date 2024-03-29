class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :payment_intent_id
      t.integer :user_id
      t.datetime :paid_At
      t.string :payment_status

      t.timestamps
    end
  end
end
