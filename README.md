[![Build Status](https://travis-ci.com/critical-path/macaddress-rb.svg?branch=master)](https://travis-ci.com/critical-path/macaddress-rb) [![Coverage Status](https://coveralls.io/repos/github/critical-path/macaddress-rb/badge.svg?branch=master)](https://coveralls.io/github/critical-path/macaddress-rb?branch=master)

## Introduction

Media access control (MAC) addresses play an important role in local-area networks.  They also pack a lot of information into 48-bit hexadecimal strings!

The macaddress library makes it easy to evaluate the properties of MAC addresses and the [extended identifiers](https://standards.ieee.org/products-services/regauth/tut/index.html) of which they are subclasses.


## Installing macaddress

macaddress is available on GitHub at https://github.com/critical-path/macaddress-rb.

To install macaddress with test-related dependencies, run the following commands from your shell.

```console
[user@host ~]$ git clone git@github.com:critical-path/macaddress-rb.git
[user@host ~]$ cd macaddress-rb
[user@host macaddress-rb]$ bundle install --with=development
```

To install macaddress without test-related dependencies, run the following commands from your shell.

```console
[user@host ~]$ git clone git@github.com:critical-path/macaddress-rb.git
[user@host ~]$ cd macaddress-rb
[user@host macaddress-rb]$ bundle install
```

## Using macaddress

While macaddress contains multiple classes, the only one with which you need to interact directly is `MediaAccessControlAddress`.

Require `macaddress`.

```ruby
irb(main)001:0> require "macaddress"
=> true
```

Instantiate `MediaAccessControlAddress` by passing in a MAC address in plain, hyphen, colon, or dot notation.

```ruby
irb(main)002:0> mac = MACAddress::MediaAccessControlAddress.new("a0b1c2d3e4f5")
=> #<MACAddress::MediaAccessControlAddress:0x00000002787628 @original="a0b1c2d3e4f5">
```

```ruby
irb(main)002:0> mac = MACAddress::MediaAccessControlAddress.new("a0-b1-c2-d3-e4-f5")
=> #<MACAddress::MediaAccessControlAddress:0x00000002787628 @original="a0-b1-c2-d3-e4-f5">
```

```ruby
irb(main)002:0> mac = MACAddress::MediaAccessControlAddress.new("a0:b1:c2:d3:e4:f5")
=> #<MACAddress::MediaAccessControlAddress:0x00000002787628 @original="a0:b1:c2:d3:e4:f5">
```

```ruby
irb(main)002:0> mac = MACAddress::MediaAccessControlAddress.new("a0b1.c2d3.e4f5")
=> #<MACAddress::MediaAccessControlAddress:0x00000002787628 @original="a0b1.c2d3.e4f5">
```

To determine whether the MAC address is a broadcast, a multicast (layer-two), or a unicast address, call the `broadcast?`, `multicast?`, and `unicast?` methods.

```ruby
irb(main)003:0> mac.broadcast?
=> false
```

```ruby
irb(main)004:0> mac.multicast?
=> false
```

```ruby
irb(main)005:0> mac.unicast?
=> true
```

To determine whether the MAC address is a universally-administered address (UAA) or a locally-administered address (LAA), call the `uaa?` and `laa?` methods.

```ruby
irb(main)006:0> mac.uaa?
=> true
```

```ruby
irb(main)007:0> mac.laa?
=> true
```

To work with the MAC address's octets, call the `octets` method, which returns six `Octet` objects.

```ruby
irb(main)008:0> mac.octets
=> [#<Octet::Octet:0x000000027b76e8 @original="a0">, #<Octet::Octet:0x000000027b7580 @original="b1">, #<Octet::Octet:0x000000027b7418 @original="c2">, #<Octet::Octet:0x000000027b72b0 @original="d3">, #<Octet::Octet:0x000000027b7148 @original="e4">, #<Octet::Octet:0x000000027b6fe0 @original="f5">]
```

To determine whether the MAC address is an extended unique identifier (EUI), an extended local identifier (ELI), or unknown, call the `type?` method.

```ruby
irb(main)009:0> mac.type?
=> "unique"
```

To determine whether the MAC address has an organizationally-unique identifier (OUI) or a company ID (CID), call the `oui?` and `cid?` methods.

```ruby
irb(main)010:0> mac.oui?
=> true
```

```ruby
irb(main)011:0> mac.cid?
=> false
```

To view the decimal equivalent of the MAC address, call the `decimal` method.

```ruby
irb(main)0:12:0> mac.decimal
=> 176685338322165 
```

To view the binary equivalent of the MAC address, call the `binary` and `reverse_binary` methods. With `binary`, the most-significant digit of each octet appears first.  With `reverse_binary`, the least-significant digit of each octet appears first.

```ruby
irb(main)013:0> mac.binary
=> "101000001011000111000010110100111110010011110101"
```

```ruby
irb(main)014:0> mac.reverse_binary
=> "000001011000110101000011110010110010011110101111"
```

To return the MAC address's two "fragments," call the `to_fragments` method.  For an EUI, this means the 24-bit OUI as the first fragment and the remaining interface-specific bits as the second fragment.  For an ELI, this means the 24-bit CID as the first fragment and the remaining interface-specific bits as the second fragment.

```ruby
irb(main)015:0> mac.to_fragments
=> ["a0b1c2", "d3e4f5"]
```

To return the MAC address in different notations, call the `to_plain_notation`, `to_hyphen_notation`, `to_colon_notation`, and `to_dot_notation` methods.

```ruby
irb(main)016:0> mac.to_plain_notation
=> "a0b1c2d3e4f5"
```

```ruby
irb(main)017:0> mac.to_hyphen_notation
=> "a0-b1-c2-d3-e4-f5"
```

```ruby
irb(main)018:0> mac.to_colon_notation
=> "a0:b1:c2:d3:e4:f5"
```

```ruby
irb(main)019:0> mac.to_dot_notation
=> "a0b1.c2d3.e4f5"
```


## Testing macaddress

To conduct testing, run the following command from your shell.

```console
[user@host macaddress-rb]$ bundle exec rake test
```


## Building the documentation

To build the documentation for macaddress, run the following command from your shell.

```console
[user@host macaddress-rb]$ bundle exec rake yard
```
