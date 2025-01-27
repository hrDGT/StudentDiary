$disciplines_message = [
  "Выберите необходимый вариант:",
  "1. Показать аналитику по семестру",
  "2. Показать аналитику по активными семестрам",
  "3. Показать аналитику по всем семестрам",
  "4. Вернуться",
]

def show_analytics_options
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
      puts "Аналитика по семестру is coming soon..."
      sleep(1)
      # some_method

    when "2"
      clear_lines($disciplines_message.size + $extra_lines_to_clear - 1)
      # Код ниже — временная заглушка
      $extra_lines_to_clear += 1
      puts "Аналитика по активным семестрам is coming soon..."
      sleep(1)
      # some_method

    when "3"
      clear_lines($disciplines_message.size + $extra_lines_to_clear - 1)
      # Код ниже — временная заглушка
      $extra_lines_to_clear += 1
      puts "Аналитика по всем семестрам is coming soon..."
      sleep(1)
      # some_method

    when "4"
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