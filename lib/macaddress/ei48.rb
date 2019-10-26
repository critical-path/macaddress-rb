# frozen_string_literal: true

require 'macaddress/octet'

# This module contains the ExtendedIdentifier class.
module EI48
  # ExtendedIdentifier48 makes it easy to work with the IEEE's 48-bit
  # extended unique identifiers (EUI) and extended local identifiers (ELI).
  #
  # The first 24 or 36 bits of an EUI is called an organizationally-
  # uniqe identifier (OUI), while the first 24 or 36 bits of an ELI is
  # called a company ID (CID).
  #
  # Visit the IEEE's website for more information on EUIs and ELIs.
  #
  # Helpful link:
  # https://standards.ieee.org/products-services/regauth/tut/index.html
  class ExtendedIdentifier48
    # Regular expressions used by ExtendedIdentifier48.
    PATTERNS = {
      PLAIN: Regexp.new('^[0-9A-Fa-f]{12}$'),
      HYPHEN: Regexp.new('^([0-9A-Fa-f]{2}[-]{1}){5}[0-9A-Fa-f]{2}$'),
      COLON: Regexp.new('^([0-9A-Fa-f]{2}[:]{1}){5}[0-9A-Fa-f]{2}$'),
      DOT: Regexp.new('^([0-9A-Fa-f]{4}[.]{1}){2}[0-9A-Fa-f]{4}$'),
      NOT_DIGITS: Regexp.new('[^0-9a-f]'),
      TWO_DIGITS: Regexp.new('[0-9a-f]{2}'),
      FOUR_DIGITS: Regexp.new('[0-9a-f]{4}')
    }.freeze

    # The hexadecimal identifier passed in by the user.
    #
    # @return [String]
    attr_reader :original

    # ExtendedIdentifier48 raises IdentifierError if instantiated
    # with an invalid argument.
    IdentifierError = Class.new(StandardError)

    # Instantiate ExtendedIdentifier48 with 12 hexadecimal digits
    # (0-9, A-F, or a-f).
    #
    # @param [String] identifier
    # @raise [IdentifierError]
    def initialize(identifier)
      @original = identifier

      raise IdentifierError, 'Pass in 12 hexadecimal digits.' unless valid?
    end

    # The string representation of ExtendedIdentifier48.
    #
    # @return [String]
    def to_s
      normalized
    end

    # Whether the user passed in a valid hexadecimal identifier.
    #
    # @return [Boolean]
    def valid?
      if PATTERNS[:PLAIN].match(@original)
        true
      elsif PATTERNS[:HYPHEN].match(@original)
        true
      elsif PATTERNS[:COLON].match(@original)
        true
      elsif PATTERNS[:DOT].match(@original)
        true
      else
        false
      end
    end

    # The hexadecimal identifier after replacing all uppercase
    # letters with lowercase letters and removing all hypens,
    # colons, and dots.
    #
    # For example, if the user passes in `A0-B1-C2-D3-E4-F5`,
    # then ExtendedIdentifier48 will return `a0b1c2d3e4f5`.
    #
    # @return [String]
    def normalized
      @original.downcase.gsub(PATTERNS[:NOT_DIGITS], '')
    end

    # Each of the hexadecimal identifier's six octets.
    #
    # @return [Array]
    def octets
      matches = normalized.scan(PATTERNS[:TWO_DIGITS])
      matches.map { |match| Octet::Octet.new(match) }
    end

    # The hexadecimal identifier's first octet.
    #
    # @return [String]
    def first_octet
      octets.first
    end

    # The decimal equivalent of the hexadecimal digits passed
    # in by the user.
    #
    # For example, if the user passes in `A0-B1-C2-D3-E4-F5`,
    # then ExtendedIdentifier48 will return `176685338322165`.
    #
    # @return [Integer]
    def decimal
      normalized.hex
    end

    # The binary equivalent of the hexadecimal identifier passed
    # in by the user.  *The most-significant digit of each
    # octet appears first.*
    #
    # For example, if the user passes in `A0-B1-C2-D3-E4-F5`,
    # then ExtendedIdentifier48 will return
    # `101000001011000111000010110100111110010011110101`.
    #
    # @return [String]
    def binary
      binaries = octets.map(&:binary)
      binaries.join('')
    end

    # The reverse-binary equivalent of the hexadecimal identifier
    # passed in by the user.  *The least-significant digit of
    # each octet appears first.*
    #
    # For example, if the user passes in `A0-B1-C2-D3-E4-F5`,
    # then ExtendedIdentifier48 will return
    # `000001011000110101000011110010110010011110101111`.
    #
    # @return [String]
    def reverse_binary
      reverse_binaries = octets.map(&:reverse_binary)
      reverse_binaries.join('')
    end

    # The hexadecimal identifier's type, where type is unique,
    # local, or unknown.
    #
    # The two least-significant bits in the first octet of
    # an extended identifier determine whether it is an EUI.
    #
    # 00 = unique.
    #
    # The four least-signficant bits in the first octet of
    # an extended identifier determine whether it is an ELI.
    #
    # 1010 = local.
    #
    # @return [String]
    def type?
      if first_octet.binary.slice(6, 7) == '00'
        'unique'
      elsif first_octet.binary.slice(4, 7) == '1010'
        'local'
      else
        'unknown'
      end
    end

    # Whether the hexadecimal identifier has an OUI.
    #
    # If the identifier is an EUI, then it has an OUI.
    #
    # @return [String]
    def oui?
      type? == 'unique'
    end

    # Whether the hexadecimal identifier has a CID.
    #
    # If the identifier is an ELI, then it has a CID.
    #
    # @return [String]
    def cid?
      type? == 'local'
    end

    # Returns the hexadecimal identifier's two "fragments."
    #
    # For an EUI, this means the 24- or 36-bit OUI as the first
    # fragment and the remaining device- or object-specific bits
    # as the second fragment.
    #
    # For an ELI, this means the 24- or 36-bit CID as the first
    # fragment and the remaining device- or object-specific bits
    # as the second fragment.
    #
    # For example, if the user passes in `A0-B1-C2-D3-E4-F5` and
    # calls this method with either `bits=24` or no keyword argument,
    # then ExtendedIdentifier48 will return `[a0b1c2, d3e4f5]`.
    #
    # If the user passes in `A0-B1-C2-D3-E4-F5` and calls this method
    # with `bits=36`, then ExtendedIdentifier48 will return
    # `[a0b1c2d3e, 4f5]`.
    #
    # @param [Fixnum] bits
    # @return [Array]
    def to_fragments(bits = 24)
      digits = bits / 4
      [normalized.slice(0, digits), normalized.slice(digits, 11)]
    end

    # Returns the hexadecimal identifier in plain notation
    # (for example, `a0b1c2d3e4f5`).
    #
    # @return [String]
    def to_plain_notation
      normalized
    end

    # Returns the hexadecimal identifier in hyphen notation
    # (for example, `a0-b1-c2-d3-e4-f5`).
    #
    # @return [String]
    def to_hyphen_notation
      matches = normalized.scan(PATTERNS[:TWO_DIGITS])
      matches.join('-')
    end

    # Returns the hexadecimal identifier in colon notation
    # (for example, `a0:b1:c2:d3:e4:f5`).
    #
    # @return [String]
    def to_colon_notation
      matches = normalized.scan(PATTERNS[:TWO_DIGITS])
      matches.join(':')
    end

    # Returns the hexadecimal identifier in dot notation
    # (for example, `a0b1.c2d3.e4f5`).
    #
    # @return [String]
    def to_dot_notation
      matches = normalized.scan(PATTERNS[:FOUR_DIGITS])
      matches.join('.')
    end
  end
end
