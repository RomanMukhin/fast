class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
<<<<<<< HEAD
    if user.present?
=======
    if user 
>>>>>>> e8e05bf50d96596ca50a0053b0f073662898b105
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
