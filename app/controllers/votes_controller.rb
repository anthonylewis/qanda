class VotesController < ApplicationController
  def up
    create_vote( 1, params[:answer_id], current_user)
  end

  def down
    create_vote(-1, params[:answer_id], current_user)
  end

  private

  def create_vote(vote, answer, user)
    @answer = Answer.find answer

    @vote = @answer.votes.create :user_id => user, :vote => vote

    @answer.update_score
    redirect_to question_path(@answer.question)
  end
end
