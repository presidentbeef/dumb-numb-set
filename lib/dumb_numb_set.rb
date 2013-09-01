# ### DumbNumbSet
#
# A DumbNumbSet is a data structure for a very specific purpose: compactly
# storing a set of mostly consecutive positive integers that may begin at
# any number.
#
# In Ruby, a Set is actually stored as a Hash with `true` as values. So the
# fairest comparison for DumbNumbSet is the same Hash a Set would use.
#
# #### Usage
#
# The API for DumbNumbSet is very simple. Numbers can be added, removed, and
# their presence in the set can be queried.
#
#     dns = DumbNumbSet.new
#     dns.add 1
#     dns.include? 1     #=> true
#     dns.remove 1
#     dns.include? 1     #=> false
#
# #### Implementation
#
# DumbNumbSet is backed by a Hash of integers. Each key represents a multiple
# of the native integer length, and each value is a bit field. Each bit in the
# value represents the presence or absence of an integer.
#
# #### Performance
#
# Performance is nearly the same as a Hash, except when inserting many
# non-consecutive values.
#
# #### Size
#
# For consecutive values, DumbNumbSet is typically ~95% smaller than a Hash when
# comparing serialized size with `Marshal.dump`.
#
class DumbNumbSet
  def initialize
    @bitsets = {}

    # Set divisor so that bit-wise operations are always performed
    # with Fixnums.
    if 1.size == 4
      @div = 29
    else
      @div = 61
    end
  end

  # Add a non-negative integer to the set.
  # Raises an ArgumentError if the number given is not a non-negative integer.
  def add num
    raise ArgumentError, "Argument must be positive integer" unless num.is_a? Fixnum and num.integer? and num >= 0

    index = num / @div

    bitset = @bitsets[index]

    if bitset
      @bitsets[index] = (bitset | (1 << (num % @div)))
    else
      @bitsets[index] = (1 << (num % @div))
    end

    self
  end

  alias << add

  # Remove number from set.
  def remove num
    index = num / @div

    bitset = @bitsets[index]

    return false unless bitset

    @bitsets[index] = (bitset ^ (1 << (num % @div)))

    if @bitsets[index] == 0
      @bitsets.delete index
    end

    num
  end

  alias delete remove

  # Returns true if the given number is in the set.
  # Raises an ArgumentError if the number given is not a non-negative integer.
  def include? num
    index = num / @div

    bitset = @bitsets[index]

    return false unless bitset

    bitset & (1 << (num % @div)) != 0
  end

  # Returns number of keys in set (not number of values).
  def size
    @bitsets.length
  end
end

# Custom marshal technique if MessagePack is available. Saves some bytes,
# especially with larger integers.
begin
  require 'msgpack'

  class DumbNumbSet
    def marshal_dump
      MessagePack.pack({:div => @div, :bitsets => @bitsets})
    end

    def marshal_load str
      info = MessagePack.unpack(str)
      @div = info["div"]
      @bitsets = info["bitsets"]
    end
  end
rescue LoadError
end
