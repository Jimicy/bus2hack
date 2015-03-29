require 'sinatra'
require 'sinatra/activerecord'
require 'warden'

#config
require './config/environments'

#require models
require './models/user'
require './models/hackathon'
require './models/hackathon_status'
require './models/bus'

class Bus2Hack < Sinatra::Application
  get '/' do
    erb :'index'
  end

  get "/protected_pages" do
    check_authentication
    "you are authenticated and on a protected_pages"
  end

  get '/login' do
    erb :'login'
  end

  post "/session" do
    warden_handler.authenticate!
    if warden_handler.authenticated?
      redirect "/users/#{warden_handler.user.id}"
    else
      redirect "/"
    end
  end

  get "/logout" do
    warden_handler.logout
    redirect '/login'
  end

  post "/unauthenticated" do
    redirect "/"
  end

  # Warden configuration code
  use Rack::Session::Cookie

  use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.failure_app = self
    manager.serialize_into_session {|user| user.id}
    manager.serialize_from_session {|id| User.find_by_id(id)}
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['email'] && params['password']
    end

    def authenticate!
      user = User.find_by(email: params['email'])

      if user.nil?
        fail!("The account you entered does not exist.")
      elsif user.authenticate(params['password'])
        success!(user)
      else
        fail!("Could not log in")
      end
    end
  end

  def warden_handler
    env['warden']
  end

  def check_authentication
    unless warden_handler.authenticated?
      redirect '/login'
    end
  end

  def current_user
    warden_handler.user
  end
end