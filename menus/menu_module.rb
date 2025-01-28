# frozen_string_literal: true

# Functionality for all menus
module BasicMenuFunctionality
  def initialize(options, matches)
    @options = options
    @matches = matches
    @extra_lines = 0
  end

  def display_options
    puts 'Выберите необходимый вариант:'
    @options.each do |key, value|
      puts "#{key}. #{value}"
    end
    process_user_response
  end

  private

  def process_user_response; end

  def clear_lines(lines_to_clear)
    (lines_to_clear + @extra_lines).times do
      print "\e[A\e[K"
    end
    @extra_lines = 0
  end
end
