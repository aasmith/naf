module Demo
  module Storage
    class RelationalDao < Dao
      attr_accessor :db, :table

      def initialize(opts = {})
        super

        self.db = opts[:db] or raise ArgumentError, "no db specified"

        if opts[:table]
          self.table = db[opts[:table]]
        else
          raise ArgumentError, "no table specified"
        end
      end

      def save_existing(obj)
        super

        table.filter(:id => obj.id).update(obj.attributes)
      end

      def save_new(obj)
        super

        obj.id = table.insert(obj.attributes)
      end

      def find(attrs)
        raise ArgumentError, "no keys to find" if attrs.empty?

        nonexistents = attrs.keys - table.columns

        unless nonexistents.empty?
          raise ArgumentError, "no column, #{nonexistents.inspect}"
        end

        result = table.filter(attrs).first

        return unless result

        bind(result)
      end

      def size
        table.count
      end
    end
  end
end
