# frozen_string_literal: true

# Clear specified number of lines
module ClearLines
  def clear_lines(lines_to_clear)
    lines_to_clear.times { print "\e[A\e[K" }
  end
end
