require 'sinatra'
require 'sinatra/activerecord'
require 'warden'
require 'json'

#config
require './config/environments'

#require models
require './models/user'
require './models/hackathon'
require './models/hackathon_status'
require './models/bus'

class Bus2Hack < Sinatra::Application
  get '/' do
    "hello world"
    # erb :'index'
  end

  get '/hackathons' do
    content_type :json

    hackathons = []

    if warden_handler.authenticated?
      Hackathon.all.each do |hackathon|
        user = current_user

        p user.hackathon_statuses.find_by(hackathon_id: hackathon.id)

        hackathon_status = user.hackathon_statuses.find_by(hackathon_id: hackathon.id)

        if hackathon_status
          status = hackathon_status.status
        else
          status = "apply"
        end

        hackathon_json = {name: hackathon.name,
                          date: hackathon.date,
                          location: hackathon.location,
                          description: hackathon.description,
                          status: status}

        hackathons << hackathon_json
      end
    end

    hackathons.to_json
  end

  get "/users/:id" do
    check_authentication
    "you are authenticated and on a protected_pages"
  end

  put "/users/id" do
    user = User.find_by_id(email: params['email']).nil?
    user.first_name = params['first_name']
    user.last_name = params['last_name']
    user.school = params['school']
    user.passport_expiry_date = Time.parse(params['passport_expiry_date'])
    user.save
  end

  post '/register' do
    email = params['email']
    password = params['password']
    unconfirmed_emails = [email]

    if User.find_by(email: params['email']).nil?
      User.new(email: email,
               password: password,
               confirmed_emails: [],
               unconfirmed_emails: unconfirmed_emails,
               bus_coordinator: "false")
    else
      #already registered
      puts "Please confirm your email"
    end
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