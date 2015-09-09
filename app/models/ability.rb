class Ability
  include CanCan::Ability

  def initialize(user)
    # if user.is_a?(AdminUser)
    #   if user.role == 'super'
    #     can :manage, :all
    #   else
    #
    #   end
    # else
    # end
  end
end
