require 'sinatra'
require 'json'

# sets root as the parent-directory of the current file
set :root, File.join(File.dirname(__FILE__), '..')

get '/' do
  erb :index
end
