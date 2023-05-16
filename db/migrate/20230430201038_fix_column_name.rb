class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :bugs, :type, :type1
  end
end
