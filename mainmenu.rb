require_relative "semesters"
require_relative "labs"
require_relative "disciplines"
require_relative "analytics"
require_relative "export"

$introduction_message = [
  "Welcome to Student Diary!",
  "Для завершения работы программы введите exit",
  "Выберите необходимый вариант:",
  "1. Семестры",
  "2. Лабы",
  "3. Дисциплины",
  "4. Аналитика",
  "5. Экспорт",
]

$extra_lines_to_clear = 0
def clear_lines(lines_to_clear)
  (lines_to_clear + $extra_lines_to_clear).times do
    print "\e[A\e[K"
  end
  $extra_lines_to_clear = 0
end

def show_mainmenu_options
  loop do
    clear_lines(0)
    puts $introduction_message
    user_choice = gets.chomp
    case user_choice
    when "1"
      clear_lines($introduction_message.size + 1)
      show_semesters_options
    when "2"
      clear_lines($introduction_message.size + 1)
      show_labs_options
    when "3"
      clear_lines($introduction_message.size + 1)
      show_disciplines_options
    when "4"
      clear_lines($introduction_message.size + 1)
      show_analytics_options
    when "5"
      clear_lines($introduction_message.size + 1)
      show_analytics_options
    when "exit"
      break
    else
      clear_lines($introduction_message.size + 1)
      $extra_lines_to_clear += 1
      puts "Некорректный ввод!"
      sleep(1)
    end
  end
end

show_mainmenu_options