class AddChangeToAddress < ActiveRecord::Migration[7.0]
  def change
    change_table :addresses do |t|
      t.references :addressable, polymorphic: true
    end
  end
end
