require 'sinatra'

get '/' do
  "hello world"
end

get '/slash' do
  "goodbye world"
  erb :'index'
end