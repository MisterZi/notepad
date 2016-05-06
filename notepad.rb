require_relative 'post.rb'
require_relative 'link.rb'
require_relative 'task.rb'
require_relative 'memo.rb'

puts 'Привет, я твой блокнот!'
puts 'Что хотите записать в блокнот?'

choices = Post.post_types

choice = -1

until choice >= 0 && choices.size

  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end

  choice = STDIN.gets.chomp.to_i
end

entry = Post.create(choice)

entry.read_from_console

entry.save

puts 'Запись сохранена'
