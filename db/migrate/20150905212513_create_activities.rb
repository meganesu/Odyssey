class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
    	t.string :name
    	t.string :description
    	# Add date, time

    	t.references :location

      t.timestamps null: false
    end
  end
end
