module Demo
  module Logging
    class SimpleLogger < Logger
      attr_reader :io

      def initialize(io = STDOUT)
        @io = io
      end

      def append(action, object)
        io.puts([action, object.class.name].join(": "))
      end
    end
  end
end
