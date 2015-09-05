class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.string :name

    	# Add map coordinates?

    	t.references :trip

      t.timestamps null: false
    end
  end
end
