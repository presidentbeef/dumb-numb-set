### Usage

    dns = DumbNumbSet.new

    dns << 1

    dns.include? 1 #True!

### Tests

    ruby test/test.rb

### Benchmarks

    ruby test/bm.rb

### Memory Test

With DumbNumbSet:

     ruby test/mem.rb

With a Hash:

     ruby test/mem.rb hash

Modify `$size`, `$multiplier` and `data` for more fun.
