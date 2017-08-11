class Ability
  include CanCan::Ability

  def initialize(user)
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

    user ||= User.new # guest user (not logged in)
    can :read, Item, active: true

    superadmin if user.has_role? :superadmin
    admin if user.has_role? :admin
    student_employee if user.has_role? :student_employee

    # Deprecated/stubbed functionality
    cannot :manage, PrintRequest unless user.has_role? :superadmin

  end

  def superadmin
    can :manage, :all
  end

  def admin
    can :manage, :all
  end

  def student_employee
    can :manage, :legacy_lending
    can :create, Item
  end

end
