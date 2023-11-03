class AddPropertyRefToAttachments < ActiveRecord::Migration[7.0]
  def change
    add_reference :attachments, :property, null: false, foreign_key: true
  end
end
