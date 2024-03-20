class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.float :rating
      t.text :review
      t.references :reviewable, polymorphic: true
      t.timestamps
    end
  end
end
