class Hackathon < ActiveRecord::Base
  has_many :buses, dependent: :destroy
  has_many :hackathon_statuses, dependent: :destroy
end