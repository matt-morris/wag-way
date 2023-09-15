class CreateWalkers < ActiveRecord::Migration[7.0]
  def change
    create_table :walkers do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :avatar_url, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.integer :radius, null: false, default: 10
      t.integer :hourly_rate_in_cents, null: false

      t.timestamps
    end
    add_index :walkers, :email, unique: true
    add_index :walkers, [:latitude, :longitude]
  end
end
