$LOAD_PATH.unshift "#{File.expand_path(File.dirname(__FILE__))}/../lib"
require 'dumb_numb_set'

srand 1283

$size = ARGV[0].to_i
$multiplier = 10

class RandThing
  def each
    $size.times do
      yield rand($size * $multiplier)
    end
  end
end

ordered = (0..$size)

data = RandThing.new
data = ordered

h = Hash.new
data.each do |d|
  h[d] = true
end

h_len = Marshal.dump(h).length

puts "Hash: #{h_len}"

ns = DumbNumbSet.new
data.each do |d|
  ns.add d
end

ns_len = Marshal.dump(ns).length

puts "DNS: #{ns_len}"

puts "Difference: #{((h_len - ns_len) / h_len.to_f) * 100}"
