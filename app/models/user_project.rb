class UserProject < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project, optional: true

  validates_uniqueness_of   :project_id, scope: :user_id

end
