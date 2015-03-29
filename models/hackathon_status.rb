class HackathonStatus < ActiveRecord::Base
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :bus, :class_name => 'Bus', :foreign_key => 'bus_id'
end