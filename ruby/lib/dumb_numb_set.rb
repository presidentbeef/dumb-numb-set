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
    check_num num

    index = bitset_index num

    bitset = @bitsets[index]

    if bitset
      @bitsets[index] = (bitset | bin_index(num))
    else
      @bitsets[index] = bin_index(num)
    end

    self
  end

  alias << add

  # Remove number from set.
  # Raises an ArgumentError if the number given is not a non-negative integer.
  def remove num
    check_num num

    index = bitset_index num

    bitset = @bitsets[index]

    return false unless bitset

    @bitsets[index] = (bitset ^ bin_index(num))

    if @bitsets[index] == 0
      @bitsets.delete index
    end

    num
  end
  # Returns true if the given number is in the set.
  def include? num
    check_num num

    index = bitset_index num

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

  # Calculate the key of the bitset for a given number.
  def bitset_index num
    (num / @div)
  end

  # Check that the argument is a valid number.
  def check_num num
    unless num.is_a? Fixnum and num.integer? and num >= 0
      raise ArgumentError, "Argument must be positive integer"
    end
  end
end
