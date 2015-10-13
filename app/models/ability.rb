class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a?(AdminUser)
      if user.role == 'super'
        can :manage, :all
      else
        can :manage, Item
      end
    else
      can [:sell, :read], Item
    end
  end
end
