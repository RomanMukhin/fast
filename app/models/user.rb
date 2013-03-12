class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :admin, :city, :name
  
  validates :name, presence: true

  has_many :offers, :class_name => "Task", :foreign_key => "consumer_id"
  has_many :tasks, :class_name => "Task", :foreign_key => "doer_id"
end
