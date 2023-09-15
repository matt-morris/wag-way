class CreateOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.string :email, null: false, index: { unique: true }
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
    add_index :owners, [:latitude, :longitude]
  end
end
