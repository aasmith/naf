module Demo
  module Controller
    # If you don't need a controller that is bound to a given service,
    # then just use a plain old controller instead for fielding web requests.
    class ServiceController < Controller
      class << self
        # TODO: this might just be a class_attribute()...
        def service(service)
          service_instance = Class === service ? service.new : service

          define_method(:service) do
            service_instance
          end
        end
      end

      # Some kind of output for listing endpoints and object schemas.
      def describe
        # TODO
      end
    end
  end
end
