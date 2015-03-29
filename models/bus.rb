class Bus < ActiveRecord::Base
  has_many :hackathon_statuses, dependent: :destroy
end