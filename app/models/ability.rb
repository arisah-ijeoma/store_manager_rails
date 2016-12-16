class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a?(AdminUser)
      if user.role == 'super'
        can :manage, :all
      else
        can :manage, Item
        can :manage, User
        can :manage, Transaction
      end
    else
      can [:sell, :read], Item
      can :update, User
    end
  end
end
