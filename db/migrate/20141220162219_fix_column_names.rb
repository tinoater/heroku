class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :widgets, :Lat, :lat
    rename_column :widgets, :Long, :long
  end
end
