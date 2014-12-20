class GeoWidgets < ActiveRecord::Migration
  def change
    change_table :widgets do |t|
      t.integer :Lat
      t.integer :Long
    end
  end
end
