class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string "name"
      t.integer "status", default: 0
      t.integer "price"
      t.integer "prop_type"
      t.integer "publish", default: 0
      t.boolean "is_paid", default: false

      t.timestamps
    end
  end
end
