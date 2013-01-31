$LOAD_PATH.unshift "#{File.expand_path(File.dirname(__FILE__))}/../lib"

require 'test/unit'
require 'dumb_numb_set'

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
end
