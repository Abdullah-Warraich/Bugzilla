class Project < ApplicationRecord
	has_many :user_projects, dependent: :destroy
	has_many :users, through: :user_projects, dependent: :destroy
	has_many :bugs, dependent: :destroy
	belongs_to :user

	# accepts_nested_attributes_for :user_projects, allow_destroy: true
	accepts_nested_attributes_for :user_projects, reject_if: :all_blank, allow_destroy: true
end
