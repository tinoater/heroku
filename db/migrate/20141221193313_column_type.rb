class ColumnType < ActiveRecord::Migration
  def change
    change_column :widgets, :lat, :float
    change_column :widgets, :long, :float
  end
end
