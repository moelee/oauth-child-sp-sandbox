class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :phone
      t.string :email
      t.string :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
