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

Some quick benchmarks for insert, remove, and lookup speed. The DNS is expected to
be a little slower, since it is trading off speed for memory conservation and
is written in Ruby, not C/Java. However, it is nearly as fast for every
operation except adding random numbers (and JRuby hashes are faster at removing
values).

Tests are run with 1 million values.

ruby 1.9.3p448 (x86\_64):
```
                               user     system      total        real
Hash add random            0.540000   0.020000   0.560000 (  0.549499)
DumbNumbSet add random     0.850000   0.020000   0.870000 (  0.864700)
Hash add in order          0.540000   0.020000   0.560000 (  0.556441)
DumbNumbSet add in order   0.490000   0.000000   0.490000 (  0.483713)
Hash add shuffled          0.570000   0.020000   0.590000 (  0.589316)
DumbNumbSet add shuffled   0.540000   0.010000   0.550000 (  0.538420)
Hash look up               0.930000   0.010000   0.940000 (  0.940849)
DNS look up                0.820000   0.000000   0.820000 (  0.818728)
Hash remove                0.980000   0.030000   1.010000 (  0.999362)
DNS remove                 0.950000   0.000000   0.950000 (  0.953170)
```

jruby 1.7.4:
```
                               user     system      total        real
Hash add random            0.590000   0.000000   0.590000 (  0.561000)
DumbNumbSet add random     1.670000   0.020000   1.690000 (  0.978000)
Hash add in order          2.580000   0.010000   2.590000 (  0.809000)
DumbNumbSet add in order   0.490000   0.000000   0.490000 (  0.319000)
Hash add shuffled          0.730000   0.000000   0.730000 (  0.591000)
DumbNumbSet add shuffled   0.440000   0.000000   0.440000 (  0.420000)
Hash look up               0.730000   0.000000   0.730000 (  0.568000)
DNS look up                0.740000   0.010000   0.750000 (  0.626000)
Hash remove                0.270000   0.000000   0.270000 (  0.201000)
DNS remove                 0.590000   0.000000   0.590000 (  0.564000)
```
