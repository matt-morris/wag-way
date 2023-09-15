class CreateWalks < ActiveRecord::Migration[7.0]
  def change
    create_table :walks do |t|
      t.integer :status, null: false, default: 0
      t.references :owner, null: false, foreign_key: true
      t.references :walker, null: false, foreign_key: true
      t.timestamp :start_at, null: false
      t.timestamp :end_at, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.references :address, null: true, foreign_key: true

      t.timestamps
    end
    add_index :walks, :status
    add_index :walks, [:latitude, :longitude]
  end
end
