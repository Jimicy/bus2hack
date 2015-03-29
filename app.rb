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
    erb :'login'
  end

  get "/users/:id" do
    check_authentication
    "you are authenticated and on a protected_pages"
  end
    
  get "/register" do
    erb :'register'
  end
    
  get "/profile" do
    erb :'profile'
  end    

  post 'register' do
    email = params['email']
    password = params['password']
    first_name = params['first_name']
    last_name = params['last_name']
    school = params['school']
    passport_expiry_date = Time.parse(params['passport_expiry_date'])
    unconfirmed_emails = [email]

    if User.find_by(email: params['email']).nil?
      User.new(email: email,
               password: password,
               first_name: first_name,
               last_name: last_name,
               school: school,
               passport_expiry_date: passport_expiry_date,
               confirmed_emails: [],
               unconfirmed_emails: unconfirmed_emails,
               bus_coordinator: "false")
    else
      #already registered
      puts "user already registed"
    end
  end

  get "/addevent" do
    erb :'addEvent'
  end

  post 'addevent' do
    # No idea how to do this
  end

  get "/manage" do
    erb :'manage'
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