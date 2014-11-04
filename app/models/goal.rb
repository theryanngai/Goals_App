class Goal < ActiveRecord::Base
  validates :user_id, :body, :title, presence: true
  validates :completed, inclusion: { in: [true, false] }
  
  belongs_to :user
end
