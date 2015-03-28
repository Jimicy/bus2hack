class HackathonStatus < ActiveRecord::Base
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :hackathon, :class_name => 'Hackathon', :foreign_key => 'hackathon_id'
end