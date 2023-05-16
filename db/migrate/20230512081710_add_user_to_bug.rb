class AddUserToBug < ActiveRecord::Migration[7.0]
  def change
    add_reference :bugs, :user, null: true, foreign_key: true
  end
end
