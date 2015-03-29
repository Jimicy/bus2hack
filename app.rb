require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'

#require models
require './models/user'
require './models/hackathon'
require './models/hackathon_status'
require './models/bus'

get '/' do
  "hello world"
  erb :'index'
end

get '/slash' do
  "goodbye world"
end