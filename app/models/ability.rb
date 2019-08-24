# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities



    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :accept, :decline, :cancel, to: :complete

    if user.present? 
      case 
        when user.has_role?(:superadmin)
          can :manage, :all
        when user.has_role?(:admin)
          # users 
          can    :crud, User
          cannot :manage, User, id: User.with_role(:admin).pluck(:id) 
          can    :assign_access_level, User
          # places
          can    :crud, Place
        else
          can    :manage, User, id: user.id
          can    :read, Place, access_level: [0..user.access_level]
          can    :create, Claim, place_id: Place.all_by_access_level(user.access_level).pluck(:id) 
          can    :read, Claim
          can    :update, Claim, id: Claim.with_role(:claimer, user).pluck(:id) 
          can    :complete, Claim, id: Claim.with_role(:claimer, user).pluck(:id) 
      end
    end
  end
end
