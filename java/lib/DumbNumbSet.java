import java.util.HashMap;
import java.lang.Long;
import java.lang.Math;

class DumbNumbSet {
  private HashMap<Integer, Long> bitsets;

  // Create new DumbNumbSet
  public DumbNumbSet() {
    this.bitsets = new HashMap<Integer, Long>();
  }

  // Add number to set
  public void add(int num) {
    int index = num / Long.SIZE;

    Long bitset = this.bitsets.get(index);

    if(bitset == null) {
      this.bitsets.put(index, binIndex(num));
    }
    else {
      this.bitsets.put(index, (bitset | binIndex(num)));
    }
  }

  // Check if number is in set
  public boolean hasValue(int num) {
    int index = num / Long.SIZE;

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
