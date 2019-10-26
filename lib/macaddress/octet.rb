# frozen_string_literal: true

# This module contains the Octet class.
module Octet
  # Octet makes it easy to convert two hexadecimal digits to eight
  # binary or reverse-binary digits.
  #
  # This is useful when working with the IEEE's extended unique
  # identifiers and extended local identifiers.
  class Octet
    # A regular expression used by Octet.
    DIGITS = Regexp.new('^[0-9A-Fa-f]{2}$')

    # The hexadecimal digits passed in by the user.
    #
    # @return [String]
    attr_reader :original

    # Octet raises OctetError if instantiated with an invalid argument.
    OctetError = Class.new(StandardError)

    # Instantiate Octet with two hexadecimal digits (0-9, A-F, or a-f).
    #
    # @param [String] digits
    # @raise [OctetError]
    def initialize(digits)
      @original = digits

      raise OctetError, 'Pass in two hexadecimal digits.' unless valid?
    end

    # The string representation of Octet.
    #
    # @return [String]
    def to_s
      normalized
    end

    # Whether the user passed in valid hexadecimal digits.
    #
    # @return [Boolean]
    def valid?
      DIGITS.match(@original) ? true : false
    end

    # The hexadecimal digits afte replacing all uppercase
    # letters with lowercase letters.
    #
    # For example, if the user passes in `A0`, then Octet
    # will return `a0`.
    #
    # @return [String]
    def normalized
      @original.downcase
    end

    # The decimal equivalent of the hexadecimal digits passed
    # in by the user.
    #
    # For example, if the user passes in `A0`, then Octet
    # will return `160`.
    #
    # @return [Integer]
    def decimal
      normalized.hex
    end

    # The binary equivalent of the hexadecimal digits passed
    # in by the user.  *The most-significant digit appears first.*
    #
    # For example, if the user passes in `A0`, then Octet
    # will return `10100000`.
    #
    # @return [String]
    def binary
      decimal.to_s(2).rjust(8, '0')
    end

    # The reverse-binary equivalent of the hexadecimal digits
    # passed in by the user.  *The least-significant digit
    # appears first.*
    #
    # For example, if the user passes in `A0`, then Octet
    # will return `00000101`.
    #
    # @return [String]
    def reverse_binary
      binary.reverse
    end
  end
end
