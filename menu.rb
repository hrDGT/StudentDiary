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
    return Utilities::LinesCleaner.instance.clear_lines(extra: @options.size + 4) if @user_input.downcase == 'exit'

    Utilities::LinesCleaner.instance.clear_lines(extra: @options.size + 2)

    validate_input ? execute : handle_input_error
  end

  def validate_input
    @options.keys.include?(@user_input)
  end

  def handle_input_error
    puts 'Ошибка ввода!'
    sleep(1)
    Utilities::LinesCleaner.instance.clear_lines(extra: 1)

    display_options
  end

  def execute
    @matches[@user_input].call
  end
end
