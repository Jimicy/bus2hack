require 'sinatra'

get '/' do
  "hello world"
  erb :'index'
end

get '/slash' do
  "goodbye world"
end