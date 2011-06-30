class Question < ActiveRecord::Base
  has_many :answers, :order => 'score DESC'
  belongs_to :user
end
