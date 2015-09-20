class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
    	t.string :name
    	t.text :description
    	t.string :start_loc
    	t.string :end_loc

    	t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :trips, [:user_id, :created_at]
  end
end
