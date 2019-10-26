# frozen_string_literal: true

require 'simplecov'
require 'minitest/autorun'
require 'macaddress'

invalid = %w[
  f
  fff
  gg
]

invalid.each do |argument|
  describe Octet::Octet do
    describe ".new(#{argument})" do
      it 'should raise an error' do
        error = assert_raises Octet::Octet::OctetError do
          Octet::Octet.new(argument)
        end

        assert_equal error.message, 'Pass in two hexadecimal digits.'
      end
    end
  end
end

valid = [
  {
    'digits' => 'A0',
    'normalized' => 'a0',
    'decimal' => 160,
    'binary' => '10100000',
    'reverse_binary' => '00000101'
  },
  {
    'digits' => 'a0',
    'normalized' => 'a0',
    'decimal' => 160,
    'binary' => '10100000',
    'reverse_binary' => '00000101'
  },
  {
    'digits' => 'B1',
    'normalized' => 'b1',
    'decimal' => 177,
    'binary' => '10110001',
    'reverse_binary' => '10001101'
  },
  {
    'digits' => 'b1',
    'normalized' => 'b1',
    'decimal' => 177,
    'binary' => '10110001',
    'reverse_binary' => '10001101'
  },
  {
    'digits' => 'C2',
    'normalized' => 'c2',
    'decimal' => 194,
    'binary' => '11000010',
    'reverse_binary' => '01000011'
  },
  {
    'digits' => 'c2',
    'normalized' => 'c2',
    'decimal' => 194,
    'binary' => '11000010',
    'reverse_binary' => '01000011'
  },
  {
    'digits' => 'D3',
    'normalized' => 'd3',
    'decimal' => 211,
    'binary' => '11010011',
    'reverse_binary' => '11001011'
  },
  {
    'digits' => 'd3',
    'normalized' => 'd3',
    'decimal' => 211,
    'binary' => '11010011',
    'reverse_binary' => '11001011'
  },
  {
    'digits' => 'E4',
    'normalized' => 'e4',
    'decimal' => 228,
    'binary' => '11100100',
    'reverse_binary' => '00100111'
  },
  {
    'digits' => 'e4',
    'decimal' => 228,
    'normalized' => 'e4',
    'binary' => '11100100',
    'reverse_binary' => '00100111'
  },
  {
    'digits' => 'F5',
    'normalized' => 'f5',
    'decimal' => 245,
    'binary' => '11110101',
    'reverse_binary' => '10101111'
  },
  {
    'digits' => 'f5',
    'normalized' => 'f5',
    'decimal' => 245,
    'binary' => '11110101',
    'reverse_binary' => '10101111'
  }
]

valid.each do |argument|
  describe Octet::Octet do
    octet = Octet::Octet.new(argument['digits'])

    describe '.to_s' do
      it "should equal #{argument['normalized']}" do
        assert_equal octet.to_s, argument['normalized']
      end
    end

    describe '.original' do
      it "should equal #{argument['digits']}" do
        assert_equal octet.original, argument['digits']
      end
    end

    describe '.normalized' do
      it "should equal #{argument['normalized']}" do
        assert_equal octet.normalized, argument['normalized']
      end
    end

    describe '.valid?' do
      it 'should equal true' do
        assert_equal octet.valid?, true
      end
    end

    describe '.decimal' do
      it "should equal #{argument['decimal']}" do
        assert_equal octet.decimal, argument['decimal']
      end
    end

    describe '.binary' do
      it "should equal #{argument['binary']}" do
        assert_equal octet.binary, argument['binary']
      end
    end

    describe '.reverse_binary' do
      it "should equal #{argument['reverse_binary']}" do
        assert_equal octet.reverse_binary, argument['reverse_binary']
      end
    end
  end
end
