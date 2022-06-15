# frozen_string_literal: true

class Ability
  include CanCan::Ability

  user ||= User.new

  def initialize(user)
    can :read, :all if user.nil?

    unless user.admin?
      can :read, :all
      can :manage, Post, author_id: user.id
      can :manage, Comment, author_id: user.id
    else
      can :manage, :all
    end
  end
end
