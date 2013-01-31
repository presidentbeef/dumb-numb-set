$LOAD_PATH.unshift "#{File.expand_path(File.dirname(__FILE__))}/../lib"
require 'dumb_numb_set'

srand 1283

$size = 100000000
$multiplier = 100

class RandThing
  def each
    $size.times do
      yield rand($size * $multiplier)
    end
  end
end

ordered = (0..$size)

data = RandThing.new

if ARGV[0] == "hash"
  h = Hash.new
  data.each do |d|
    h[d] = true
  end
else
  ns = DumbNumbSet.new
  data.each do |d|
    ns.add d
  end
end

puts `ps aux | grep "ruby mem.rb"`
