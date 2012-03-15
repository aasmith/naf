module Demo
  # Application level errors
  module Errors
    class AuthorizationFailure < StandardError; end
    class NoPermissionError < StandardError; end
  end
end
