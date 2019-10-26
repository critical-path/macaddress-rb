# frozen_string_literal: true

require 'simplecov'
require 'minitest/autorun'
require 'macaddress'

invalid = [
  '0a',                 # Too few digits
  '0a1b2c3d4e5f6',      # Too many digits
  '0a1b2c3d4e5g',       # Invalid digit
  '-0a-1b-2c-3d-4e-5f', # Leading hyphen
  '0a-1b-2c-3d-4e-5f-', # Trailing hyphen
  '0a-1b-2c-3d-4e5f',   # Missing hyphen
  ':0a:1b:2c:3d:4e:5f', # Leading colon
  '0a:1b:2c:3d:4e:5f:', # Trailing colon
  '0a:1b:2c:3d:4e5f',   # Missing colon
  '.0a1b.2c3d.4e5f',    # Leading dot
  '0a1b.2c3d.4e5f.',    # Trailing dot
  '0a1b.2c3d4e5f'       # Missing dot
]

invalid.each do |argument|
  describe EI48::ExtendedIdentifier48 do
    describe ".new(#{argument})" do
      it 'should raise an error' do
        error = assert_raises EI48::ExtendedIdentifier48::IdentifierError do
          EI48::ExtendedIdentifier48.new(argument)
        end

        assert_equal error.message, 'Pass in 12 hexadecimal digits.'
      end
    end
  end
end

euis = [
  {
    'digits' => 'a0b1c2d3e4f5',
    'normalized' => 'a0b1c2d3e4f5',
    'decimal' => 176685338322165,
    'binary' => '101000001011000111000010110100111110010011110101',
    'reverse_binary' => '000001011000110101000011110010110010011110101111',
    'fragments24' => %w[a0b1c2 d3e4f5],
    'fragments36' => %w[a0b1c2d3e 4f5],
    'plain' => 'a0b1c2d3e4f5',
    'hyphen' => 'a0-b1-c2-d3-e4-f5',
    'colon' => 'a0:b1:c2:d3:e4:f5',
    'dot' => 'a0b1.c2d3.e4f5'
  },
  {
    'digits' => 'A0B1C2D3E4F5',
    'normalized' => 'a0b1c2d3e4f5',
    'decimal' => 176685338322165,
    'binary' => '101000001011000111000010110100111110010011110101',
    'reverse_binary' => '000001011000110101000011110010110010011110101111',
    'fragments24' => %w[a0b1c2 d3e4f5],
    'fragments36' => %w[a0b1c2d3e 4f5],
    'plain' => 'a0b1c2d3e4f5',
    'hyphen' => 'a0-b1-c2-d3-e4-f5',
    'colon' => 'a0:b1:c2:d3:e4:f5',
    'dot' => 'a0b1.c2d3.e4f5'
  },
  {
    'digits' => 'a0-b1-c2-d3-e4-f5',
    'normalized' => 'a0b1c2d3e4f5',
    'decimal' => 176685338322165,
    'binary' => '101000001011000111000010110100111110010011110101',
    'reverse_binary' => '000001011000110101000011110010110010011110101111',
    'fragments24' => %w[a0b1c2 d3e4f5],
    'fragments36' => %w[a0b1c2d3e 4f5],
    'plain' => 'a0b1c2d3e4f5',
    'hyphen' => 'a0-b1-c2-d3-e4-f5',
    'colon' => 'a0:b1:c2:d3:e4:f5',
    'dot' => 'a0b1.c2d3.e4f5'
  },
  {
    'digits' => 'A0-B1-C2-D3-E4-F5',
    'normalized' => 'a0b1c2d3e4f5',
    'decimal' => 176685338322165,
    'binary' => '101000001011000111000010110100111110010011110101',
    'reverse_binary' => '000001011000110101000011110010110010011110101111',
    'fragments24' => %w[a0b1c2 d3e4f5],
    'fragments36' => %w[a0b1c2d3e 4f5],
    'plain' => 'a0b1c2d3e4f5',
    'hyphen' => 'a0-b1-c2-d3-e4-f5',
    'colon' => 'a0:b1:c2:d3:e4:f5',
    'dot' => 'a0b1.c2d3.e4f5'
  },
  {
    'digits' => 'a0:b1:c2:d3:e4:f5',
    'normalized' => 'a0b1c2d3e4f5',
    'decimal' => 176685338322165,
    'binary' => '101000001011000111000010110100111110010011110101',
    'reverse_binary' => '000001011000110101000011110010110010011110101111',
    'fragments24' => %w[a0b1c2 d3e4f5],
    'fragments36' => %w[a0b1c2d3e 4f5],
    'plain' => 'a0b1c2d3e4f5',
    'hyphen' => 'a0-b1-c2-d3-e4-f5',
    'colon' => 'a0:b1:c2:d3:e4:f5',
    'dot' => 'a0b1.c2d3.e4f5'
  },
  {
    'digits' => 'A0:B1:C2:D3:E4:F5',
    'normalized' => 'a0b1c2d3e4f5',
    'decimal' => 176685338322165,
    'binary' => '101000001011000111000010110100111110010011110101',
    'reverse_binary' => '000001011000110101000011110010110010011110101111',
    'fragments24' => %w[a0b1c2 d3e4f5],
    'fragments36' => %w[a0b1c2d3e 4f5],
    'plain' => 'a0b1c2d3e4f5',
    'hyphen' => 'a0-b1-c2-d3-e4-f5',
    'colon' => 'a0:b1:c2:d3:e4:f5',
    'dot' => 'a0b1.c2d3.e4f5'
  },
  {
    'digits' => 'a0b1.c2d3.e4f5',
    'normalized' => 'a0b1c2d3e4f5',
    'decimal' => 176685338322165,
    'binary' => '101000001011000111000010110100111110010011110101',
    'reverse_binary' => '000001011000110101000011110010110010011110101111',
    'fragments24' => %w[a0b1c2 d3e4f5],
    'fragments36' => %w[a0b1c2d3e 4f5],
    'plain' => 'a0b1c2d3e4f5',
    'hyphen' => 'a0-b1-c2-d3-e4-f5',
    'colon' => 'a0:b1:c2:d3:e4:f5',
    'dot' => 'a0b1.c2d3.e4f5'
  },
  {
    'digits' => 'A0B1.C2D3.E4F5',
    'normalized' => 'a0b1c2d3e4f5',
    'decimal' => 176685338322165,
    'binary' => '101000001011000111000010110100111110010011110101',
    'reverse_binary' => '000001011000110101000011110010110010011110101111',
    'fragments24' => %w[a0b1c2 d3e4f5],
    'fragments36' => %w[a0b1c2d3e 4f5],
    'plain' => 'a0b1c2d3e4f5',
    'hyphen' => 'a0-b1-c2-d3-e4-f5',
    'colon' => 'a0:b1:c2:d3:e4:f5',
    'dot' => 'a0b1.c2d3.e4f5'
  }
]

euis.each do |argument|
  describe EI48::ExtendedIdentifier48 do
    ei48 = EI48::ExtendedIdentifier48.new(argument['digits'])

    describe '.to_s' do
      it "should equal #{argument['normalized']}" do
        assert_equal ei48.to_s, argument['normalized']
      end
    end

    describe '.original' do
      it "should equal #{argument['digits']}" do
        assert_equal ei48.original, argument['digits']
      end
    end

    describe '.normalized' do
      it "should equal #{argument['normalized']}" do
        assert_equal ei48.normalized, argument['normalized']
      end
    end

    describe '.valid?' do
      it 'should equal true' do
        assert_equal ei48.valid?, true
      end
    end

    describe '.octets.length' do
      it 'should equal 6' do
        assert_equal ei48.octets.length, 6
      end
    end

    describe '.first_octet' do
      it 'should be a kind of of EI48::ExtendedIdentifier48' do
        assert_kind_of EI48::ExtendedIdentifier48, ei48
      end
    end

    describe '.decimal' do
      it "should equal #{argument['decimal']}" do
        assert_equal ei48.decimal, argument['decimal']
      end
    end

    describe '.binary' do
      it "should equal #{argument['binary']}" do
        assert_equal ei48.binary, argument['binary']
      end
    end

    describe '.reverse_binary' do
      it "should equal #{argument['reverse_binary']}" do
        assert_equal ei48.reverse_binary, argument['reverse_binary']
      end
    end

    describe '.type?' do
      it "should equal #{argument['type']}" do
        assert_equal ei48.type?, 'unique'
      end
    end

    describe '.oui?' do
      it 'should equal true' do
        assert_equal ei48.oui?, true
      end
    end

    describe '.cid?' do
      it 'should equal false' do
        assert_equal ei48.cid?, false
      end
    end

    describe '.to_fragments' do
      it "should equal #{argument['fragments24']}" do
        assert_equal ei48.to_fragments, argument['fragments24']
      end
    end

    describe '.to_fragments(bits = 36)' do
      it "should equal #{argument['fragments36']}" do
        assert_equal ei48.to_fragments(bits = 36), argument['fragments36']
      end
    end

    describe '.to_plain_notation' do
      it "should equal #{argument['plain']}" do
        assert_equal ei48.to_plain_notation, argument['plain']
      end
    end

    describe '.to_hyphen_notation' do
      it "should equal #{argument['hyphen']}" do
        assert_equal ei48.to_hyphen_notation, argument['hyphen']
      end
    end

    describe '.to_colon_notation' do
      it "should equal #{argument['colon']}" do
        assert_equal ei48.to_colon_notation, argument['colon']
      end
    end

    describe '.to_dot_notation' do
      it "should equal #{argument['dot']}" do
        assert_equal ei48.to_dot_notation, argument['dot']
      end
    end
  end
end

elis = [
  {
    'digits' => '0a1b2c3d4e5f',
    'normalized' => '0a1b2c3d4e5f',
    'decimal' => 11111822610015,
    'binary' => '000010100001101100101100001111010100111001011111',
    'reverse_binary' => '010100001101100000110100101111000111001011111010',
    'fragments24' => %w[0a1b2c 3d4e5f],
    'fragments36' => %w[0a1b2c3d4 e5f],
    'plain' => '0a1b2c3d4e5f',
    'hyphen' => '0a-1b-2c-3d-4e-5f',
    'colon' => '0a:1b:2c:3d:4e:5f',
    'dot' => '0a1b.2c3d.4e5f'
  },
  {
    'digits' => '0A1B2C3D4E5F',
    'normalized' => '0a1b2c3d4e5f',
    'decimal' => 11111822610015,
    'binary' => '000010100001101100101100001111010100111001011111',
    'reverse_binary' => '010100001101100000110100101111000111001011111010',
    'fragments24' => %w[0a1b2c 3d4e5f],
    'fragments36' => %w[0a1b2c3d4 e5f],
    'plain' => '0a1b2c3d4e5f',
    'hyphen' => '0a-1b-2c-3d-4e-5f',
    'colon' => '0a:1b:2c:3d:4e:5f',
    'dot' => '0a1b.2c3d.4e5f'
  },
  {
    'digits' => '0a-1b-2c-3d-4e-5f',
    'normalized' => '0a1b2c3d4e5f',
    'decimal' => 11111822610015,
    'binary' => '000010100001101100101100001111010100111001011111',
    'reverse_binary' => '010100001101100000110100101111000111001011111010',
    'fragments24' => %w[0a1b2c 3d4e5f],
    'fragments36' => %w[0a1b2c3d4 e5f],
    'plain' => '0a1b2c3d4e5f',
    'hyphen' => '0a-1b-2c-3d-4e-5f',
    'colon' => '0a:1b:2c:3d:4e:5f',
    'dot' => '0a1b.2c3d.4e5f'
  },
  {
    'digits' => '0A-1B-2C-3D-4E-5F',
    'normalized' => '0a1b2c3d4e5f',
    'decimal' => 11111822610015,
    'binary' => '000010100001101100101100001111010100111001011111',
    'reverse_binary' => '010100001101100000110100101111000111001011111010',
    'fragments24' => %w[0a1b2c 3d4e5f],
    'fragments36' => %w[0a1b2c3d4 e5f],
    'plain' => '0a1b2c3d4e5f',
    'hyphen' => '0a-1b-2c-3d-4e-5f',
    'colon' => '0a:1b:2c:3d:4e:5f',
    'dot' => '0a1b.2c3d.4e5f'
  },
  {
    'digits' => '0a:1b:2c:3d:4e:5f',
    'normalized' => '0a1b2c3d4e5f',
    'decimal' => 11111822610015,
    'binary' => '000010100001101100101100001111010100111001011111',
    'reverse_binary' => '010100001101100000110100101111000111001011111010',
    'fragments24' => %w[0a1b2c 3d4e5f],
    'fragments36' => %w[0a1b2c3d4 e5f],
    'plain' => '0a1b2c3d4e5f',
    'hyphen' => '0a-1b-2c-3d-4e-5f',
    'colon' => '0a:1b:2c:3d:4e:5f',
    'dot' => '0a1b.2c3d.4e5f'
  },
  {
    'digits' => '0A:1B:2C:3D:4E:5F',
    'normalized' => '0a1b2c3d4e5f',
    'decimal' => 11111822610015,
    'binary' => '000010100001101100101100001111010100111001011111',
    'reverse_binary' => '010100001101100000110100101111000111001011111010',
    'fragments24' => %w[0a1b2c 3d4e5f],
    'fragments36' => %w[0a1b2c3d4 e5f],
    'plain' => '0a1b2c3d4e5f',
    'hyphen' => '0a-1b-2c-3d-4e-5f',
    'colon' => '0a:1b:2c:3d:4e:5f',
    'dot' => '0a1b.2c3d.4e5f'
  },
  {
    'digits' => '0a1b.2c3d.4e5f',
    'normalized' => '0a1b2c3d4e5f',
    'decimal' => 11111822610015,
    'binary' => '000010100001101100101100001111010100111001011111',
    'reverse_binary' => '010100001101100000110100101111000111001011111010',
    'fragments24' => %w[0a1b2c 3d4e5f],
    'fragments36' => %w[0a1b2c3d4 e5f],
    'plain' => '0a1b2c3d4e5f',
    'hyphen' => '0a-1b-2c-3d-4e-5f',
    'colon' => '0a:1b:2c:3d:4e:5f',
    'dot' => '0a1b.2c3d.4e5f'
  },
  {
    'digits' => '0A1B.2C3D.4E5F',
    'normalized' => '0a1b2c3d4e5f',
    'decimal' => 11111822610015,
    'binary' => '000010100001101100101100001111010100111001011111',
    'reverse_binary' => '010100001101100000110100101111000111001011111010',
    'fragments24' => %w[0a1b2c 3d4e5f],
    'fragments36' => %w[0a1b2c3d4 e5f],
    'plain' => '0a1b2c3d4e5f',
    'hyphen' => '0a-1b-2c-3d-4e-5f',
    'colon' => '0a:1b:2c:3d:4e:5f',
    'dot' => '0a1b.2c3d.4e5f'
  }
]

elis.each do |argument|
  describe EI48::ExtendedIdentifier48 do
    ei48 = EI48::ExtendedIdentifier48.new(argument['digits'])

    describe '.to_s' do
      it "should equal #{argument['normalized']}" do
        assert_equal ei48.to_s, argument['normalized']
      end
    end

    describe '.original' do
      it "should equal #{argument['digits']}" do
        assert_equal ei48.original, argument['digits']
      end
    end

    describe '.normalized' do
      it "should equal #{argument['normalized']}" do
        assert_equal ei48.normalized, argument['normalized']
      end
    end

    describe '.valid?' do
      it 'should equal true' do
        assert_equal ei48.valid?, true
      end
    end

    describe '.octets.length' do
      it 'should equal 6' do
        assert_equal ei48.octets.length, 6
      end
    end

    describe '.first_octet' do
      it 'should be a kind of of EI48::ExtendedIdentifier48' do
        assert_kind_of EI48::ExtendedIdentifier48, ei48
      end
    end

    describe '.decimal' do
      it "should equal #{argument['decimal']}" do
        assert_equal ei48.decimal, argument['decimal']
      end
    end

    describe '.binary' do
      it "should equal #{argument['binary']}" do
        assert_equal ei48.binary, argument['binary']
      end
    end

    describe '.reverse_binary' do
      it "should equal #{argument['reverse_binary']}" do
        assert_equal ei48.reverse_binary, argument['reverse_binary']
      end
    end

    describe '.type?' do
      it "should equal #{argument['type']}" do
        assert_equal ei48.type?, 'local'
      end
    end

    describe '.oui?' do
      it 'should equal true' do
        assert_equal ei48.oui?, false
      end
    end

    describe '.cid?' do
      it 'should equal false' do
        assert_equal ei48.cid?, true
      end
    end

    describe '.to_fragments' do
      it "should equal #{argument['fragments24']}" do
        assert_equal ei48.to_fragments, argument['fragments24']
      end
    end

    describe '.to_fragments(bits = 36)' do
      it "should equal #{argument['fragments36']}" do
        assert_equal ei48.to_fragments(bits = 36), argument['fragments36']
      end
    end

    describe '.to_plain_notation' do
      it "should equal #{argument['plain']}" do
        assert_equal ei48.to_plain_notation, argument['plain']
      end
    end

    describe '.to_hyphen_notation' do
      it "should equal #{argument['hyphen']}" do
        assert_equal ei48.to_hyphen_notation, argument['hyphen']
      end
    end

    describe '.to_colon_notation' do
      it "should equal #{argument['colon']}" do
        assert_equal ei48.to_colon_notation, argument['colon']
      end
    end

    describe '.to_dot_notation' do
      it "should equal #{argument['dot']}" do
        assert_equal ei48.to_dot_notation, argument['dot']
      end
    end
  end
end

null_euis = [
  {
    'digits' => 'ffffffffffff',
    'normalized' => 'ffffffffffff',
    'decimal' => 281474976710655,
    'binary' => '111111111111111111111111111111111111111111111111',
    'reverse_binary' => '111111111111111111111111111111111111111111111111',
    'fragments24' => %w[ffffff ffffff],
    'fragments36' => %w[fffffffff fff],
    'plain' => 'ffffffffffff',
    'hyphen' => 'ff-ff-ff-ff-ff-ff',
    'colon' => 'ff:ff:ff:ff:ff:ff',
    'dot' => 'ffff.ffff.ffff'
  },
  {
    'digits' => 'FFFFFFFFFFFF',
    'normalized' => 'ffffffffffff',
    'decimal' => 281474976710655,
    'binary' => '111111111111111111111111111111111111111111111111',
    'reverse_binary' => '111111111111111111111111111111111111111111111111',
    'fragments24' => %w[ffffff ffffff],
    'fragments36' => %w[fffffffff fff],
    'plain' => 'ffffffffffff',
    'hyphen' => 'ff-ff-ff-ff-ff-ff',
    'colon' => 'ff:ff:ff:ff:ff:ff',
    'dot' => 'ffff.ffff.ffff'
  },
  {
    'digits' => 'ff-ff-ff-ff-ff-ff',
    'normalized' => 'ffffffffffff',
    'decimal' => 281474976710655,
    'binary' => '111111111111111111111111111111111111111111111111',
    'reverse_binary' => '111111111111111111111111111111111111111111111111',
    'fragments24' => %w[ffffff ffffff],
    'fragments36' => %w[fffffffff fff],
    'plain' => 'ffffffffffff',
    'hyphen' => 'ff-ff-ff-ff-ff-ff',
    'colon' => 'ff:ff:ff:ff:ff:ff',
    'dot' => 'ffff.ffff.ffff'
  },
  {
    'digits' => 'FF-FF-FF-FF-FF-FF',
    'normalized' => 'ffffffffffff',
    'decimal' => 281474976710655,
    'binary' => '111111111111111111111111111111111111111111111111',
    'reverse_binary' => '111111111111111111111111111111111111111111111111',
    'fragments24' => %w[ffffff ffffff],
    'fragments36' => %w[fffffffff fff],
    'plain' => 'ffffffffffff',
    'hyphen' => 'ff-ff-ff-ff-ff-ff',
    'colon' => 'ff:ff:ff:ff:ff:ff',
    'dot' => 'ffff.ffff.ffff'
  },
  {
    'digits' => 'ff:ff:ff:ff:ff:ff',
    'normalized' => 'ffffffffffff',
    'decimal' => 281474976710655,
    'binary' => '111111111111111111111111111111111111111111111111',
    'reverse_binary' => '111111111111111111111111111111111111111111111111',
    'fragments24' => %w[ffffff ffffff],
    'fragments36' => %w[fffffffff fff],
    'plain' => 'ffffffffffff',
    'hyphen' => 'ff-ff-ff-ff-ff-ff',
    'colon' => 'ff:ff:ff:ff:ff:ff',
    'dot' => 'ffff.ffff.ffff'
  },
  {
    'digits' => 'FF:FF:FF:FF:FF:FF',
    'normalized' => 'ffffffffffff',
    'decimal' => 281474976710655,
    'binary' => '111111111111111111111111111111111111111111111111',
    'reverse_binary' => '111111111111111111111111111111111111111111111111',
    'fragments24' => %w[ffffff ffffff],
    'fragments36' => %w[fffffffff fff],
    'plain' => 'ffffffffffff',
    'hyphen' => 'ff-ff-ff-ff-ff-ff',
    'colon' => 'ff:ff:ff:ff:ff:ff',
    'dot' => 'ffff.ffff.ffff'
  },
  {
    'digits' => 'ffff.ffff.ffff',
    'normalized' => 'ffffffffffff',
    'decimal' => 281474976710655,
    'binary' => '111111111111111111111111111111111111111111111111',
    'reverse_binary' => '111111111111111111111111111111111111111111111111',
    'fragments24' => %w[ffffff ffffff],
    'fragments36' => %w[fffffffff fff],
    'plain' => 'ffffffffffff',
    'hyphen' => 'ff-ff-ff-ff-ff-ff',
    'colon' => 'ff:ff:ff:ff:ff:ff',
    'dot' => 'ffff.ffff.ffff'
  },
  {
    'digits' => 'FFFF.FFFF.FFFF',
    'normalized' => 'ffffffffffff',
    'decimal' => 281474976710655,
    'binary' => '111111111111111111111111111111111111111111111111',
    'reverse_binary' => '111111111111111111111111111111111111111111111111',
    'fragments24' => %w[ffffff ffffff],
    'fragments36' => %w[fffffffff fff],
    'plain' => 'ffffffffffff',
    'hyphen' => 'ff-ff-ff-ff-ff-ff',
    'colon' => 'ff:ff:ff:ff:ff:ff',
    'dot' => 'ffff.ffff.ffff'
  }
]

null_euis.each do |argument|
  describe EI48::ExtendedIdentifier48 do
    ei48 = EI48::ExtendedIdentifier48.new(argument['digits'])

    describe '.to_s' do
      it "should equal #{argument['normalized']}" do
        assert_equal ei48.to_s, argument['normalized']
      end
    end

    describe '.original' do
      it "should equal #{argument['digits']}" do
        assert_equal ei48.original, argument['digits']
      end
    end

    describe '.normalized' do
      it "should equal #{argument['normalized']}" do
        assert_equal ei48.normalized, argument['normalized']
      end
    end

    describe '.valid?' do
      it 'should equal true' do
        assert_equal ei48.valid?, true
      end
    end

    describe '.octets.length' do
      it 'should equal 6' do
        assert_equal ei48.octets.length, 6
      end
    end

    describe '.first_octet' do
      it 'should be a kind of of EI48::ExtendedIdentifier48' do
        assert_kind_of EI48::ExtendedIdentifier48, ei48
      end
    end

    describe '.decimal' do
      it "should equal #{argument['decimal']}" do
        assert_equal ei48.decimal, argument['decimal']
      end
    end

    describe '.binary' do
      it "should equal #{argument['binary']}" do
        assert_equal ei48.binary, argument['binary']
      end
    end

    describe '.reverse_binary' do
      it "should equal #{argument['reverse_binary']}" do
        assert_equal ei48.reverse_binary, argument['reverse_binary']
      end
    end

    describe '.type?' do
      it "should equal #{argument['type']}" do
        assert_equal ei48.type?, 'unknown'
      end
    end

    describe '.oui?' do
      it 'should equal true' do
        assert_equal ei48.oui?, false
      end
    end

    describe '.cid?' do
      it 'should equal false' do
        assert_equal ei48.cid?, false
      end
    end

    describe '.to_fragments' do
      it "should equal #{argument['fragments24']}" do
        assert_equal ei48.to_fragments, argument['fragments24']
      end
    end

    describe '.to_fragments(bits = 36)' do
      it "should equal #{argument['fragments36']}" do
        assert_equal ei48.to_fragments(bits = 36), argument['fragments36']
      end
    end

    describe '.to_plain_notation' do
      it "should equal #{argument['plain']}" do
        assert_equal ei48.to_plain_notation, argument['plain']
      end
    end

    describe '.to_hyphen_notation' do
      it "should equal #{argument['hyphen']}" do
        assert_equal ei48.to_hyphen_notation, argument['hyphen']
      end
    end

    describe '.to_colon_notation' do
      it "should equal #{argument['colon']}" do
        assert_equal ei48.to_colon_notation, argument['colon']
      end
    end

    describe '.to_dot_notation' do
      it "should equal #{argument['dot']}" do
        assert_equal ei48.to_dot_notation, argument['dot']
      end
    end
  end
end
