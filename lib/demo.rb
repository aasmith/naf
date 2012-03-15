require "active_model"
require "active_support/core_ext/class/attribute"
require "active_support/core_ext/kernel/reporting"
require "active_support/json"

silence_warnings do
  require "sequel"
  require "sinatra/base"
end


require "demo/errors"

require "demo/logging/logger"
require "demo/logging/simple_logger"

require "demo/model/util/attribute_assigner"
require "demo/model/util/attribute_accessor"

require "demo/model/model"
require "demo/model/line_item"
require "demo/model/order"
require "demo/model/product"
require "demo/model/user"

require "demo/storage/dao"
require "demo/storage/memory_dao"
require "demo/storage/relational_dao"

# TODO: with slight changes, these stores could be generic key-value stores.
require "demo/storage/hashed_token_store"
require "demo/storage/redis_token_store"

require "demo/service/util/authorization"

require "demo/service/service"
require "demo/service/order_service"
require "demo/service/product_service"
require "demo/service/token_service"

require "demo/controller/controller"
require "demo/controller/service_controller"
require "demo/controller/product_controller"
require "demo/controller/token_controller"

require "demo/config"

module Demo
  VERSION = '1.0.0'
end
