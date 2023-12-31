class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :postal_code, null: false
      t.string :country_code, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
    add_index :addresses, [:latitude, :longitude]
  end
end
