class Ability
  include CanCan::Ability

  def initialize(user, ip)
    # Define abilities for the passed in user here.
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

    # Abilities for logged-in users
    if user
      can :read, :reservation
      can :read, :inventory
      can :make, :resource_requests
    end

    user ||= User.new # guest user (not logged in)

    # In production, fill in with allowed admins, operators, and IPs
    superadmins = []
    admins = []
    tech_advisors = []
    operators = []
    operator_ips = []

    superadmin if user.has_role? :superadmin
    admin if user.has_role? :admin
    if user.has_role? :operator
      if operator_ips.include? ip
        local_operator
      else
        remote_operator
      end
    end

    superadmin if superadmins.include? user.andrewid
    admin if admins.include? user.andrewid
    tech_advisor if tech_advisors.include? user.andrewid
    if operators.include? user.andrewid
      if operator_ips.include? ip
        local_operator
      else
        remote_operator
      end
    end

    # Deprecated/stubbed functionality
    cannot :manage, PrintRequest unless user.has_role? :superadmin
    cannot :manage, Item unless user.has_role? :superadmin

  end

  def superadmin
    can :manage, :all
  end

  def admin
    can :manage, :all
  end

  def tech_advisor
    can :manage, :tech_advisor
    can :read, :lending_shift_schedule
  end

  def local_operator
    can :manage, :legacy_lending
    # Local operators also have all the abilities that remote ones do
    remote_operator
  end

  def remote_operator
    can :read, :lending_shift_schedule
  end

end
