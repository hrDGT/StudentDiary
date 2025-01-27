$semesters_message = [
  "Выберите необходимый вариант:",
  "1. Управление семестрами",
  "2. Посмотреть семестры",
  "3. Вернуться",
]

def show_semesters_options
  loop do
    clear_lines(0)
    puts $semesters_message
    user_choice = gets.chomp
    $extra_lines_to_clear += 1
    case user_choice
    when "1"
      clear_lines($semesters_message.size + $extra_lines_to_clear - 1)
      # Код ниже — временная заглушка
      $extra_lines_to_clear += 1
      puts "Управление семестрами is coming soon..."
      sleep(1)
      # some_method

    when "2"
      clear_lines($semesters_message.size + $extra_lines_to_clear - 1)
      # Код ниже — временная заглушка
      $extra_lines_to_clear += 1
      puts "Просмотр семестров is coming soon..."
      sleep(1)
      # some_method

    when "3"
      clear_lines($semesters_message.size + $extra_lines_to_clear - 1)
      break
    else
      clear_lines($semesters_message.size)
      $extra_lines_to_clear += 1
      puts "Некорректный ввод!"
      sleep(1)
      # Придумать вариант лучше???
    end
  end
end