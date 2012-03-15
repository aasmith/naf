require "demo"

## Global config (dev).

# TODO: use seperate dev and prod config files.

# Redis instance or something else...
Demo::Service::Service.token_store = Demo::Storage::HashedTokenStore.new




# pretend production sql database!
bob = Demo::Model::User.new
bob.name = "bob"
bob.level = Demo::Service::Util::Authorization::Regular
bob.password = "user"

jeff = Demo::Model::User.new
jeff.name = "jeff"
jeff.level = Demo::Service::Util::Authorization::Administrator
jeff.password = "admin"

db = Sequel.sqlite("x.db")

db.create_table! :x do
  primary_key :id
  string :name
  string :level
  string :email
  string :password
end

token_dao = Demo::Storage::RelationalDao.new(
  :db => db,
  :table => :x,
  :binder => Demo::Model::User)

token_dao.save bob
token_dao.save jeff

Demo::Service::TokenService.dao = token_dao

Demo::Service::Service.authorization_dao = token_dao

## END CONFIG




# Set up top-level paths using Rack::Builder:

use Rack::Runtime

map "/products" do
  run Demo::Controller::ProductController
end

map "/token" do
  run Demo::Controller::TokenController
end

# Catch-all
map "/" do
  run Demo::Controller::Controller
end

