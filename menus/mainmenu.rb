# frozen_string_literal: true

# Class for main page
class MainMenu
  include BasicMenuFunctionality

  def display_options
    puts "Welcome to Student Diary!\nДля выхода из программы введите exit"
    super
  end

  private

  def process_user_response
    @response = gets.chomp
    if @response == 'exit'
      clear_lines(@options.size + 4)
      return
    end
    @matches.each do |key, value|
      next unless key.to_s == @response

      # temporary
      clear_lines(@options.size + @extra_lines + 4)
      value.display_options
      display_options
      return
    end
    puts 'Ошибка ввода!'
    @extra_lines += 1
    process_user_response
  end
end
