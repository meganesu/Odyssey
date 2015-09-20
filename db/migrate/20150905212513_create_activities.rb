class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
    	t.string :name
    	t.text :description
    	t.datetime :start_datetime
    	t.datetime :end_datetime

    	t.references :location

      t.timestamps null: false
    end
  end
end
