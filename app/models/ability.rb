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
      can [:update, :destroy], Item
    end
  end
end
