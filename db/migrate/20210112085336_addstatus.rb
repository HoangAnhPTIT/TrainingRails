class Addstatus < ActiveRecord::Migration[6.1]
  def change
    add_column :logs, :status, :boolean
  end
end
