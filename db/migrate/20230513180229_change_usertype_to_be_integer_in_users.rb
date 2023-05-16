class ChangeUsertypeToBeIntegerInUsers < ActiveRecord::Migration[7.0]
  def up
    # change_column :users, :usertype, :integer
    change_column :users, :usertype, 'integer USING CAST(usertype AS integer)'
  end

  def down
    change_column :users, :usertype, :string
  end
end
