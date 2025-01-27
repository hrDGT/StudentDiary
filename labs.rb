$labs_message = [
  "Выберите необходимый вариант:",
  "1. Управление лабами",
  "2. Посмотреть лабы",
  "3. Вернуться",
]

def show_labs_options
  loop do
    clear_lines(0)
    puts $labs_message
    user_choice = gets.chomp
    $extra_lines_to_clear += 1
    case user_choice
    when "1"
      clear_lines($labs_message.size + $extra_lines_to_clear - 1)
      # Код ниже — временная заглушка
      $extra_lines_to_clear += 1
      puts "Управление лабами is coming soon..."
      sleep(1)
      # some_method

    when "2"
      clear_lines($labs_message.size + $extra_lines_to_clear - 1)
      # Код ниже — временная заглушка
      $extra_lines_to_clear += 1
      puts "Просмотр лабами is coming soon..."
      sleep(1)
      # some_method

    when "3"
      clear_lines($labs_message.size + $extra_lines_to_clear - 1)
      break
    else
      clear_lines($labs_message.size)
      $extra_lines_to_clear += 1
      puts "Некорректный ввод!"
      sleep(1)
      # Придумать вариант лучше???
    end
  end
end