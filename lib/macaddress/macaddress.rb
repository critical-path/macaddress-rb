# frozen_string_literal: true

require 'macaddress/ei48'

# This module contains the MediaAccessControlAddress class.
module MACAddress
  # MediaAccessControlAddress makes it easy to work with media access
  # control (MAC) addresses.
  class MediaAccessControlAddress < EI48::ExtendedIdentifier48
    # MediaAccessControlAddress raises AddressError if instantiated
    # with an invalid argument.
    AddressError = Class.new(StandardError)

    # Instantiate MediaAccessControlAddress with 12 hexadecimal digits
    # (0-9, A-F, a-f).
    #
    # @param [String] address
    # @raise [AddressError]
    def initialize(address)
      super(address)
    rescue EI48::ExtendedIdentifier48::IdentifierError
      raise AddressError, 'Pass in 12 hexadecimal digits.'
    end

    # Whether the MAC address is a broadcast address.
    #
    # "ffffffffffff" = broadcast.
    #
    # @return [Boolean]
    def broadcast?
      normalized == 'ffffffffffff'
    end

    # Whether the MAC address is a multicast address
    # (layer-two multicast, not layer-three multicast).
    #
    # The least-significant bit in the first octet of a MAC address
    # determines whether it is a multicast or a unicast.
    #
    # 1 = multicast.
    #
    # @return [Boolean]
    def multicast?
      first_octet.binary.slice(7) == '1'
    end

    # Whether the MAC address is a unicast address.
    #
    # The least-significant bit in the first octet of a MAC address
    # determines whether it is a multicast or a unicast.
    #
    # 0 = unicast.
    #
    # @return [Boolean]
    def unicast?
      !multicast?
    end

    # Whether the MAC address is a universally-administered
    # address (UAA).
    #
    # The second-least-significant bit in the first octet of a MAC
    # address determines whether it is a UAA or an LAA.
    #
    # 0 = UAA.
    #
    # @return [Boolean]
    def uaa?
      unicast? && first_octet.binary.slice(6) == '0' ? true : false
    end

    # Whether the MAC address is a locally-administered
    # address (LAA).
    #
    # The second-least-significant bit in the first octet of a MAC
    # address determines whether it is a UAA or an LAA.
    #
    # 1 = LAA.
    #
    # @return [Boolean]
    def laa?
      unicast? && first_octet.binary.slice(6) == '1' ? true : false
    end
  end
end
