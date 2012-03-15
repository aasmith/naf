require "demo/helper"

module Demo
  module Storage
    class TestMemoryDao < TestCase
      Person = Struct.new(:id, :name, :discard) do
        def attributes
          # Note that the "discard" variable is not output here,
          # so it should not be serialized by any dao implementation.
          { :id => id, :name => name }
        end
      end

      def setup
        @dao = MemoryDao.new(:binder => Person)
      end

      def test_save_new
        bob = Person.new(nil, "bob")

        assert_equal 0, @dao.size
        refute bob.id, "should be no id present for new objects"

        @dao.save(bob)

        assert_equal 1, @dao.size
        assert bob.id, "an id should be assigned once saved"
      end

      def test_save_existing
        bob = Person.new(nil, "bob")
        @dao.save(bob)

        assert_equal 1, @dao.size, "should be one object present"

        # Change the existing name for "bob" to "robert".
        old_id = bob.id
        bob.name = "Robert"

        @dao.save(bob)
        assert_equal 1, @dao.size, "no more objects should be added
          when an attribute is changed on an existing object"

        robert = @dao.find(:name => "Robert")

        assert_equal old_id, robert.id
        assert_equal "Robert", robert.name
      end

      def test_find
        bob = Person.new(nil, "bob")
        @dao.save(bob)

        assert_equal bob.name, @dao.find(:name => bob.name).name
        assert_equal bob.id, @dao.find(:id => bob.id).id

        newbob = @dao.find(:name => bob.name, :id => bob.id)
        assert_equal bob.name, newbob.name
        assert_equal bob.id, newbob.id
      end

      def test_find_nothing
        bob = Person.new(nil, "bob")
        @dao.save(bob)

        assert_raises ArgumentError, "find without args should error" do
          @dao.find
        end

        assert_raises ArgumentError, "find with an empty hash should error" do
          @dao.find({})
        end

        refute @dao.find(:name => "bo"), "nonexistant value should find nothing"

        assert_raises(ArgumentError, "should complain no such field") do
          @dao.find(:na => "bob")
        end

        refute @dao.find(:name => bob.name, :id => "nonexistant"),
          "should only find object when all conditions are satisfied"
      end

      def test_dao_only_saves_attributes
        bob = Person.new(nil, "bob", 123)
        @dao.save(bob)

        new_bob = @dao.find(:id => bob.id)

        refute new_bob.discard, "the discard value should not be stored"
      end
    end
  end
end
