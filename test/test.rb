$LOAD_PATH.unshift "#{File.expand_path(File.dirname(__FILE__))}/../lib"

require 'test/unit'
require 'dumb_numb_set'
require 'set'

class TestDumbNumbSet < Test::Unit::TestCase
  def setup
    @ns = DumbNumbSet.new
  end

  def assert_include? num
    assert @ns.include?(num), "Expected #{num} to be in set"
  end

  def assert_not_include? num
    assert !@ns.include?(num), "Expected #{num} not to be in set"
  end

  def test_simple_add
    @ns.add 1
    assert_include? 1
    assert_not_include? 0
  end

  def test_add
    @ns.add 10
    assert_include? 10
    
    @ns.add 8123
    assert_include? 10
    assert_include? 8123

    @ns.add 62
    assert_include? 10
    assert_include? 8123
    assert_include? 62
    assert_not_include? 61
    assert_not_include? 63
  end

  def test_merge
    @ns.add 1
    @ns.add 2
    @ns.merge 1..100
    101.times do |i|
      @ns.include? i
    end
  end

  def test_ordered
    100000.times do |i|
      @ns.add i
      assert_include? i
    end
  end

  def test_every_other
    100000.times do |i|
      if i.odd?
        @ns.add i
        assert_include? i
      else
        assert_not_include? i
      end
    end
  end

  def test_double
    1.upto 10000 do |i|
      @ns.add i * 2
      assert_include? i * 2
    end
  end

  def test_remove
    1000.times do |i|
      @ns.add i
      assert_include? i
      @ns.remove i
      assert_not_include? i
    end

    assert_equal 0, @ns.size
  end

  def test_invalid_input
    assert_raises ArgumentError do
      @ns.add -1
    end

    assert_raises ArgumentError do
      @ns.add 4.2
    end

    assert_raises ArgumentError do
      @ns.add false
    end
  end

  def test_to_a
    assert_equal [], @ns.to_a

    @ns.add 1
    assert_equal [1], @ns.to_a

    @ns.add 255
    assert_equal [1, 255], @ns.to_a

    @ns.add 12345678
    assert_equal [1, 255, 12345678], @ns.to_a

    @ns.add 61
    assert_equal [1, 255, 12345678, 61], @ns.to_a
  end

  def test_to_set
    set = Set[0, 60, 61, 62, 1048576]

    set.each do |v|
      @ns.add v
    end

    assert_equal set, @ns.to_set
  end
end
