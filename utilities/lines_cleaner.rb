# frozen_string_literal: true

module Utilities
  # Сlass responsible for cleaning lines throughout the program
  class LinesCleaner
    attr_accessor :lines_to_clear

    def initialize
      @lines_to_clear = 0
    end

    @instance = new

    private_class_method :new

    class << self
      attr_reader :instance
    end

    def clear_lines(extra: 0)
      (extra + @lines_to_clear).times { print "\e[A\e[K" }
      @lines_to_clear = 0
    end
  end
end
