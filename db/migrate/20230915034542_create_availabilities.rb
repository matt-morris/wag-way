class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities do |t|
      t.references :walker, null: false, foreign_key: true
      t.timestamp :start_at
      t.timestamp :end_at

      t.timestamps
    end
  end
end
