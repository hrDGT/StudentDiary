# frozen_string_literal: true

# Class for secondary page
class SubMenu
  include BasicMenuFunctionality

  private

  def process_user_response
    @response = gets.chomp
    if @response == @options.size.to_s
      clear_lines(@options.size + @extra_lines + 2)
      return
    end
    @matches.each do |key, value|
      next unless key.to_s == @response

      clear_lines(@options.size + @extra_lines + 2)

      # temporary
      value.call
      sleep(0.5)
      clear_lines(1)
      return
    end
    puts 'Ошибка ввода!'
    @extra_lines += 1
    process_user_response
  end
end
