class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
    	t.string :name
    	t.string :description
    	t.string :start_loc
    	t.string :end_loc

    	t.references :user

      t.timestamps null: false
    end
  end
end
