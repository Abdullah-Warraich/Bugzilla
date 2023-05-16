class Bug < ApplicationRecord
  belongs_to :project

  # enum :status, feature: "feature", bug: "bug"

end
