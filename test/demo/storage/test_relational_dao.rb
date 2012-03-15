require "demo/helper"

module Demo
  module Storage
    class TestRelationalDao < TestMemoryDao
      def setup
        db = Sequel.sqlite
        db.create_table :people do
          primary_key :id
          string :name
        end

        @dao = RelationalDao.new(:db => db, :table => :people, :binder => Person)
      end
    end
  end
end
