class User < ActiveRecord::Base
  has_many :hackathon_statuses, dependent: :destroy
end