$disciplines_message = [
  "Выберите необходимый вариант:",
  "1. Управление дисциплинами",
  "2. Посмотреть дисциплины",
  "3. Вернуться",
]

def show_disciplines_options
  loop do
    clear_lines(0)
    puts $disciplines_message
    user_choice = gets.chomp
    $extra_lines_to_clear += 1
    case user_choice
    when "1"
      clear_lines($disciplines_message.size + $extra_lines_to_clear - 1)
      # Код ниже — временная заглушка
      $extra_lines_to_clear += 1
      puts "Управление дисциплинами is coming soon..."
      sleep(1)
      # some_method

    when "2"
      clear_lines($disciplines_message.size + $extra_lines_to_clear - 1)
      # Код ниже — временная заглушка
      $extra_lines_to_clear += 1
      puts "Просмотр дисциплин is coming soon..."
      sleep(1)
      # some_method

    when "3"
      clear_lines($disciplines_message.size + $extra_lines_to_clear - 1)
      break
    else
      clear_lines($disciplines_message.size)
      $extra_lines_to_clear += 1
      puts "Некорректный ввод!"
      sleep(1)
      # Придумать вариант лучше???
    end
  end
end