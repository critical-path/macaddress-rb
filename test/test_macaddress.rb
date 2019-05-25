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
  describe MACAddress::MediaAccessControlAddress do
    describe ".new(#{argument})" do
      it 'should raise an error' do
        error = assert_raises MACAddress::MediaAccessControlAddress::AddressError do
          MACAddress::MediaAccessControlAddress.new(argument)
        end

        assert_equal error.message, 'Pass in 12 hexadecimal digits.'
      end
    end
  end
end

broadcast = 'ffffffffffff'

describe MACAddress::MediaAccessControlAddress do
  mac = MACAddress::MediaAccessControlAddress.new(broadcast)

  describe '.broadcast?' do
    it 'should equal true' do
      assert_equal mac.broadcast?, true
    end
  end

  describe '.multicast?' do
    it 'should equal true' do
      assert_equal mac.multicast?, true
    end
  end

  describe '.unicast?' do
    it 'should equal false' do
      assert_equal mac.unicast?, false
    end
  end

  describe '.uaa?' do
    it 'should equal false' do
      assert_equal mac.uaa?, false
    end
  end

  describe '.laa?' do
    it 'should equal false' do
      assert_equal mac.laa?, false
    end
  end

  describe '.type?' do
    it 'should equal unknown' do
      assert_equal mac.type?, 'unknown'
    end
  end

  describe '.oui?' do
    it 'should equal false' do
      assert_equal mac.oui?, false
    end
  end

  describe '.cid?' do
    it 'should equal false' do
      assert_equal mac.cid?, false
    end
  end
end

multicast = '0180c2000000' ## Link-Layer Discovery Protocol

describe MACAddress::MediaAccessControlAddress do
  mac = MACAddress::MediaAccessControlAddress.new(multicast)

  describe '.broadcast?' do
    it 'should equal false' do
      assert_equal mac.broadcast?, false
    end
  end

  describe '.multicast?' do
    it 'should equal true' do
      assert_equal mac.multicast?, true
    end
  end

  describe '.unicast?' do
    it 'should equal false' do
      assert_equal mac.unicast?, false
    end
  end

  describe '.uaa?' do
    it 'should equal false' do
      assert_equal mac.uaa?, false
    end
  end

  describe '.laa?' do
    it 'should equal false' do
      assert_equal mac.laa?, false
    end
  end

  describe '.type?' do
    it 'should equal unknown' do
      assert_equal mac.type?, 'unknown'
    end
  end

  describe '.oui?' do
    it 'should equal false' do
      assert_equal mac.oui?, false
    end
  end

  describe '.cid?' do
    it 'should equal false' do
      assert_equal mac.cid?, false
    end
  end
end

unicast_uaa = 'a0b1c2d3e4f5'

describe MACAddress::MediaAccessControlAddress do
  mac = MACAddress::MediaAccessControlAddress.new(unicast_uaa)

  describe '.broadcast?' do
    it 'should equal false' do
      assert_equal mac.broadcast?, false
    end
  end

  describe '.multicast?' do
    it 'should equal false' do
      assert_equal mac.multicast?, false
    end
  end

  describe '.unicast?' do
    it 'should equal true' do
      assert_equal mac.unicast?, true
    end
  end

  describe '.uaa?' do
    it 'should equal true' do
      assert_equal mac.uaa?, true
    end
  end

  describe '.laa?' do
    it 'should equal false' do
      assert_equal mac.laa?, false
    end
  end

  describe '.type?' do
    it 'should equal unique' do
      assert_equal mac.type?, 'unique'
    end
  end

  describe '.oui?' do
    it 'should equal true' do
      assert_equal mac.oui?, true
    end
  end

  describe '.cid?' do
    it 'should equal false' do
      assert_equal mac.cid?, false
    end
  end
end

unicast_laa = 'aab1c2d3e4f5'

describe MACAddress::MediaAccessControlAddress do
  mac = MACAddress::MediaAccessControlAddress.new(unicast_laa)

  describe '.broadcast?' do
    it 'should equal false' do
      assert_equal mac.broadcast?, false
    end
  end

  describe '.multicast?' do
    it 'should equal false' do
      assert_equal mac.multicast?, false
    end
  end

  describe '.unicast?' do
    it 'should equal true' do
      assert_equal mac.unicast?, true
    end
  end

  describe '.uaa?' do
    it 'should equal false' do
      assert_equal mac.uaa?, false
    end
  end

  describe '.laa?' do
    it 'should equal true' do
      assert_equal mac.laa?, true
    end
  end

  describe '.type?' do
    it 'should equal local' do
      assert_equal mac.type?, 'local'
    end
  end

  describe '.oui?' do
    it 'should equal false' do
      assert_equal mac.oui?, false
    end
  end

  describe '.cid?' do
    it 'should equal true' do
      assert_equal mac.cid?, true
    end
  end
end
