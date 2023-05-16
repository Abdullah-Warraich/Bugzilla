class AddUserToProjects < ActiveRecord::Migration[7.0]
  def change
    add_reference :projects, :user, not_null: false, foreign_key: true
  end
end
