class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.string :name
    	t.datetime :arrival
    	t.datetime :departure

    	# Add map coordinates?

    	t.references :trip, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
