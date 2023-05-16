class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects
  has_many :user_projects
  has_many :projects, through: :user_projects

      # enum :status, { manager: 0, developer: 1, QA: 2 }, prefix: true, scopes: false
  enum usertype: [:manager, :developer, :QA]



  def is?( requested_role )
    self.usertype == requested_role.to_s
  end
end
