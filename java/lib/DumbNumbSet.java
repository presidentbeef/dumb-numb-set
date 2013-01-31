import java.util.HashMap;
import java.lang.Long;
import java.lang.Math;

class DumbNumbSet {
  private HashMap<Long, Long> bitsets;

  // Create new DumbNumbSet
  public DumbNumbSet() {
    this.bitsets = new HashMap<Long, Long>();
  }

  // Add number to set
  public void add(long num) {
    long index = num / Long.SIZE;

    Long bitset = this.bitsets.get(index);

    if(bitset == null) {
      this.bitsets.put(index, binIndex(num));
    }
    else {
      this.bitsets.put(index, (bitset | binIndex(num)));
    }
  }

  // Check if number is in set
  public boolean hasValue(long num) {
    long index = num / Long.SIZE;

    Long bitset = this.bitsets.get(index);

    if(bitset == null) {
      return false;
    }
    else {
      return bitset == (bitset | binIndex(num));
    }
  }

  // Return number of keys in set (not number of values)
  public int size() {
    return this.bitsets.size();
  }

  private long binIndex(long num) {
    return (long) Math.pow(2, (num % Long.SIZE));
  }
}
