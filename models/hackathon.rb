class Hackathon < ActiveRecord::Base
  has_many :buses, dependent: :destroy
end