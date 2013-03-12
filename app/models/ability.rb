class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user 
      if user.admin
        can :manage, :all
      else
        can :read, :all
        can :manage, User, id: user.id
        can [:create, :cancel, :edit, :update], Task, consumer_id: user.id
        can :cancel, Task, doer_id: user.id
        can :apply, Task, doer_id: nil
        cannot :apply, Task, consumer_id: user.id
        can [:confirm, :destroy], Task, consumer_id: user.id
      end
    end
  end
end
