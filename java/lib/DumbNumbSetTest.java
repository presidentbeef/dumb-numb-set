import java.util.Random;
import java.lang.Runtime;
import java.util.HashMap;

class DumbNumbSetTest {

  public static void main(String[] args) throws Exception {
    int size = new Integer(args[0]);;
    Random r = new Random(6283);
    HashMap<Integer, Boolean> h = new HashMap<Integer, Boolean>();
    DumbNumbSet ns = new DumbNumbSet();

    if(args.length == 2 && args[1].equals("hash")) {

      for(int i = 0; i < size; i++) {
        int n = r.nextInt(size * 100);
        h.put(n, true);
        //h.put(i, true);
        if(h.get(n) == null) {
          throw new Exception();
        }
      }
    }
    else {
      for(int i = 0; i < size; i++) {
        int n = r.nextInt(size * 100);
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
