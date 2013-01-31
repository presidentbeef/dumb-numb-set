$LOAD_PATH.unshift "#{File.expand_path(File.dirname(__FILE__))}/../lib"

require 'benchmark'
require 'dumb_numb_set'

size = 100000

def hash_add data
  h = Hash.new

  data.each do |d|
    h[d] = true
  end
end

def ns_add data
  ns = DumbNumbSet.new

  data.each do |d|
    ns.add d
  end
end

rand_data = Array.new(size) { rand(size * 100) }
order_data = (0..size).to_a
shuffle_data = (0..size).to_a.shuffle!

Benchmark.bmbm do |t|
  t.report "Hash add random" do
    hash_add rand_data
  end

  t.report "DumbNumbSet add random" do
    ns_add rand_data
  end

  t.report "Hash add in order" do
    hash_add order_data
  end

  t.report "DumbNumbSet add in order" do
    ns_add order_data
  end

  t.report "Hash add shuffled" do
    hash_add shuffle_data
  end

  t.report "DumbNumbSet add shuffled" do
    ns_add shuffle_data
  end
end
