class DumbNumbSet
  def initialize
    @bitsets = {}

    if 1.size == 4
      @div = 29 #might be wrong!
    else
      @div = 61
    end
  end

  # Add a non-negative integer to the set.
  # Raises an ArgumentError if the number given is not a non-negative integer.
  def add num
    raise ArgumentError if num < 0 or not num.integer?

    index = num / @div

    bitset = @bitsets[index]

    if bitset
      @bitsets[index] = (bitset | bin_index(num))
    else
      @bitsets[index] = bin_index(num)
    end

    self
  end

  alias << add

  # Returns true if the given number is in the set.
  def include? num
    return false unless num >= 0 or not num.integer?

    index = num / @div

    bitset = @bitsets[index]

    return false unless bitset

    bitset & bin_index(num) != 0
  end

  # Returns number of keys in set (not number of values).
  def size
    @bitsets.length
  end

  private

  def bin_index num
    1 << (num % @div)
  end
end
