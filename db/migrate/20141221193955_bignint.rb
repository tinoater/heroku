class Bignint < ActiveRecord::Migration
  def change
    change_column :widgets, :stock, :bigint
  end
end
