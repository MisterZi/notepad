# encoding: utf-8
# Программа "Блокнот" Версия 2.0, хранящая свои данные в базе данных SQLite
# Этот скрипт создает новые записи, чтением занимается другой скрипт

# XXX/ Этот код необходим только при использовании русских букв на Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
# /XXX

# Подключаем класс Post и его детей
require_relative 'post.rb'
require_relative 'memo.rb'
require_relative 'link.rb'
require_relative 'task.rb'

puts 'Привет, я блокнот версия 2, записываю новые записи в базу SQLite'

# Теперь надо спросить у пользователя, что он хочет создать
puts 'Что хотите записать сегодня?'

# массив возможных видов Записи (поста)
choices = Post.post_types.keys
choice = -1

until choice >= 0 && choice < choices.size # пока юзер не выбрал правильно
  # выводим заново массив возможных типов поста
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end
  choice = gets.chomp.to_i
end

# выбор сделан, создаем запись с помощью стат. метода класса Post
entry = Post.create(choices[choice])

# Просим пользователя ввести пост (каким бы он ни был)
entry.read_from_console

# Сохраняем пост в базу данных
rowid = entry.save_to_db

puts "Запись сохранена в базе, id = #{rowid}"
