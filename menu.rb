# frozen_string_literal: true

# Functionality for all menus
class Menu
  def initialize(options:, matches:)
    @options = options
    @matches = matches
  end

  def display_options
    puts 'Выберите необходимый вариант:'
    @options.each { |key, value| puts "#{key}. #{value}" }

    process_user_input
  end

  private

  def process_user_input
    @user_input = gets.chomp
    return clear_lines(@options.size + 6) if @user_input == 'exit'

    clear_lines(@options.size + 2)

    validate_input ? execute : handle_input_error
  end

  def validate_input
    @options.keys.include?(@user_input)
  end

  def handle_input_error
    puts 'Ошибка ввода!'
    sleep(1)
    clear_lines(1)

    display_options
  end

  def execute
    @matches[@user_input].call
  end

  def clear_lines(lines_to_clear)
    lines_to_clear.times { print "\e[A\e[K" }
  end
end
