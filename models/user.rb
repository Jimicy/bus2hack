class User < ActiveRecord::Base
  has_many :hackathon_statuses, dependent: :destroy

  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end