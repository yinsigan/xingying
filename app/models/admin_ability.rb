class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user && !user.user?
        can :access, :rails_admin
        can :dashboard
        if user.super_admin?
            can :manage, :all
        elsif user.admin?
            can :manage, :all
            cannot :destroy, [Support, SupportCategory, User, Ticket, Contact]
            cannot :new, [Ticket, Contact]
        end
    end
  end
end
