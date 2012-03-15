module Demo
  module Storage
    class MemoryDao < Dao
      attr_accessor :db

      def initialize(opts = {})
        super

        self.db = opts[:db] || []
      end

      def save_existing(obj)
        super

        db.delete_if { |hash| hash[:id] == obj.id }

        db << obj.attributes
      end

      def save_new(obj)
        super

        obj.id = SecureRandom.uuid

        db << obj.attributes
      end

      def find(attrs)
        raise ArgumentError, "no keys to find" if attrs.empty?

        result = db.detect do |hash|
          attrs.all? do |attr, val|
            if hash.key? attr
              hash[attr] == val
            else
              raise ArgumentError, "no such field #{attr.inspect}"
            end
          end
        end

        bind result if result
      end

      def size
        db.size
      end
    end
  end
end
