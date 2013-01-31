import java.util.Random;
import java.lang.Runtime;
import java.util.HashMap;

class DumbNumbSetTest {

  public static void main(String[] args) throws Exception {
    int size = 1000000;
    Random r = new Random(6283);
    HashMap<Long, Boolean> h = new HashMap<Long, Boolean>();
    DumbNumbSet ns = new DumbNumbSet();

    if(args.length == 1 && args[0].equals("hash")) {

      for(int i = 0; i < size; i++) {
        long n = (long) r.nextInt(size * 10);
        h.put(n, true);
        //h.put((long)i, true);
        if(h.get(n) == null) {
          throw new Exception();
        }
      }
    }
    else {
      for(int i = 0; i < size; i++) {
        long n = (long) r.nextInt(size * 10);
        ns.add(n);
        //ns.add(i);
        if(!ns.hasValue(n)) {
          throw new Exception();
        }

      }
    }

    System.gc();

    long used = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();

    System.out.println(used);
    System.out.println("NS: " + ns.size());
    System.out.println("H: " + h.size());
  }
}
