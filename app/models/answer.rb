class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :votes

  def update_score
    self.score = Vote.where( :answer_id => self.id ).sum( 'vote' )
    self.save
  end
end
