class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, 
    :password_confirmation, :remember_me,
    :username, :role, :photo

  ROLES = ['admin', 'moderator', 'user']

  has_attached_file :photo

  has_many :questions
  has_many :answers
  has_many :votes

  has_many :answered_questions, :through => :answers, :source => :question
  has_many :voted_answers, :through => :votes, :source => :answer
end

