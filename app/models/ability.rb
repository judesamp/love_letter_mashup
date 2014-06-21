class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.has_role? :admin
        can :manage, :all
      else
        can :index, Letter
        can :show, Letter
        can :create, Letter
        can :create_with_snippet, Letter
        can :add_or_subtract_snippet, Letter
        can :update_positions, Letter
        can :create_with_quiz, Letter
        can :process_question_return_snippet, Letter
        can :retrieve_letter, Letter
        can :switch_workspace, Letter
        can :build_snippet_letter, Letter
        can :build_quiz_letter, Letter

        can :show, LetterOrder, :user_id => user.id
        can :create, LetterOrder, :user_id => user.id
        can :cancel, LetterOrder, :user_id => user.id
        can :checkout, LetterOrder, :user_id => user.id
        can :charge_create, LetterOrder, :user_id => user.id
        can :deliver_as_email, LetterOrder, :user_id => user.id

      end
    



    # user ||= User.new # guest user (not logged in)
    #   if user.has_role? :admin
    #     can :manage, :all
    #   else
    #     can :show, Assignment
    #     can :show, Cohort
    #     can :dashboard, User
    #     can :show, Submission, :user_id => user.id
       
    #     can :create, Comment
    #     can :create, Submission
    #     can :update, Submission, :user_id => user.id
    #     can :resubmit, Submission, :user_id => user.id
    #   end
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
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
