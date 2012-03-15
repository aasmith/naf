module Demo
  module Storage
    # An empty dao. Does no load/store, but validates arguments.
    #
    # All dao implementations should extend this class and be sure to
    # call super in methods.
    #
    # A dao can store an object that provides an attribute method with
    # a hash of key-value pairs to be stored. Data read back from the dao
    # is stored into an in instance of the class in the binder variable.
    class Dao
      attr_accessor :binder

      def initialize(opts = {})
        self.binder = opts[:binder]
      end

      undef binder=
      def binder=(binder)
        if binder.nil?
          raise ArgumentError, "binder must be specified"
        end

        unless binder.respond_to? :new
          raise ArgumentError, "binder must allow new instances"
        end

        @binder = binder
      end

      def save(obj)
        obj.id ? save_existing(obj) : save_new(obj)
      end

      def save_existing(obj)
        raise ArgumentError, "object id expected" unless obj.id
      end

      def save_new(obj)
        if obj.id
          raise ArgumentError, "no object id expected but was #{obj.id.inspect}"
        end
      end

      def find(obj)
      end

      def all
      end

      # Utility method for binding a hash back to an object.
      def bind(hash)
        out = binder.new
        hash.each do |k,v|
          out.send "#{k}=", v
        end
        out
      end
    end
  end
end
