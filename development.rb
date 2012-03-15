## Global config (dev).

include Demo

# Redis instance or something else...
Demo::Config.token_store = Storage::HashedTokenStore.new




# pretend production sql database!
bob = Model::User.new
bob.name = "bob"
bob.level = Service::Util::Authorization::Regular
bob.password = "user"

jeff = Model::User.new
jeff.name = "jeff"
jeff.level = Service::Util::Authorization::Administrator
jeff.password = "admin"

db = Sequel.sqlite("x.db")

db.create_table! :x do
  primary_key :id
  string :name
  string :level
  string :email
  string :password
end

token_dao = Storage::RelationalDao.new(
  :db => db,
  :table => :x,
  :binder => Model::User)

token_dao.save bob
token_dao.save jeff

Service::TokenService.dao = token_dao

Service::Service.authorization_dao = token_dao


