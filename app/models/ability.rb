# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
        can :home, :all
        can :access, :rails_admin
        can :read, :home
    user ||= User.new
    # if user.is? :manager
    if user.manager?
        # can :manage, Project do |project|
        #   users = project.users
        #   users.include? user
        # end
        can :manage, Project, user_id: user.id
        can :create, Project
    # elsif user.is? :developer
    elsif user.developer?
      can :read, Project do |project|
          users = project.users
          users.include? user
        end
      can :assign, Bug
      can :read, Bug
      can :edit, Bug
      can :update, Bug
    else
      can :read, Project
      can :searchproject, Project
      can :manage, Bug
    end
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
