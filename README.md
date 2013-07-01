## DNS

The DumbNumbSet (DNS) is intended to be somewhat efficient storage for mostly
consecutive, positive integers. In particular, the serialized size should be
small for sending over the network. Memory usage should be similarly less than
a stock set or hash table.

Note that the starting value of a consecutive set of integers does not matter,
nor do large gaps in between consecutive sets. But lots of sparse data does not
work so well.

### Installation

    gem install dumb_numb_set

Optionally:

    gem install msgpack

### Usage

    require 'dumb_numb_set'

    dns = DumbNumbSet.new

    dns << 1

    dns.include? 1  #=> true

    dns.remove 1

    dns.include? 1  #=> false

### Tests

    ruby test/test.rb

### Benchmarks

    ruby test/bm.rb

### Memory Test

     ruby test/mem.rb SIZE

Modify `$multiplier` and `data` for more fun.

### Serialized Size

#### Perfectly Dense Data

This is the best case scenario for the DNS: a list of consecutive integers.

The values below are the length of the serialized data structure from `Marshal.dump`
using `ruby 1.9.3p392 (2013-02-22 revision 39386) [x86_64-linux]`.

    Items        Hash         DNS      %reduction
    ---------------------------------------------
      1k   |        4632  |       253   |  95%
     10k   |       49632  |      2211   |  96%
    100k   |      534098  |     24254   |  95%
      1M   |     5934098  |    245565   |  96%
     10M   |    59934098  |   2557080   |  96%
    100M   |   683156884  |  26163639   |  96%
      1B   |         ?    | 262229211   |   ?
    ---------------------------------------------

For even smaller serialized sizes, install the [MessagePack](http://msgpack.org/)
and the DNS will automatically use it in conjuction with `Marshal`.

For 1 billion items, my machine ran out of memory (16GB).

#### Less Dense Data

The less dense the data is, the less benefit a DNS provides. In the worse case,
DNS is equivalent to a hash table, i.e. one key per value stored.

In the tables below, random values were used in the range 0-(size * 30). This
allows significant gaps to form in the data. For even sparser data, DNS
starts to be less efficient than a hash table.

    Items        Hash         DNS      %reduction
    ---------------------------------------------
      1k   |        4921 |      5121   |  -4% (worse)
     10k   |       57045 |     53621   |   6%
    100k   |      588230 |    537184   |   9%
      1M   |     6334404 |   5758291   |   9%
     10M   |    68298120 |   58082016  |   15%
    100M   |   751061842 | 609400600   |   29%
      1B   |          ?  |         ?   |   ?
    ---------------------------------------------


For 1 billion items, my machine ran out of memory (16GB).

### Speed

Some quick benchmarks for insertion and lookup speed. The DNS is expected to
be a little slower, since it is trading off speed for memory conservation and
is written in Ruby, not C. However, it is nearly as fast for every operation
except adding random numbers.

Tests are run with 1 million values.

```
                               user     system      total        real
Hash add random            0.580000   0.000000   0.580000 (  0.578994)
DumbNumbSet add random     1.060000   0.000000   1.060000 (  1.056919)
Hash add in order          0.580000   0.000000   0.580000 (  0.584013)
DumbNumbSet add in order   0.620000   0.000000   0.620000 (  0.625693)
Hash add shuffled          0.590000   0.000000   0.590000 (  0.582023)
DumbNumbSet add shuffled   0.690000   0.000000   0.690000 (  0.696846)
Hash look up               1.010000   0.000000   1.010000 (  1.018742)
DNS look up                1.080000   0.000000   1.080000 (  1.082430)

```
