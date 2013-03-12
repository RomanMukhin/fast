class Task < ActiveRecord::Base
  attr_accessible :consumer_id, :description, :doer_id, :title, :state
  belongs_to :consumer, :foreign_key => "consumer_id", :class_name => "User"
  belongs_to :doer, :foreign_key => "doer_id", :class_name => "User"
  
  scope :undone, where(doer_id: nil)
  scope :done, where('doer_id IS NOT NULL')
  
  validates :consumer_id, presence: true
  validates :title, presence: true
  
  state_machine :state, :initial => :ready do

    event :cancel do
      transition :in_process => :ready
    end

    event :apply do
      transition :ready => :in_process
    end

    event :finish do
      transition :in_process => :done
    end
  end
end
