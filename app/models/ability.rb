class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'moderator'
      can :manage, Question
    elsif user.role == 'user'
      can [:create, :read], Question
      can [:create, :read], Answer
      can :create, Vote
      can :manage, Question, :user_id => user.id
    else
      can :read, [Question, Answer]
    end
  end
end

