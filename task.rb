# encoding: utf-8
# Программа "Блокнот"

# Подключим встроенный в руби класс Date для работы с датами
require 'date'

# Класс Задача, разновидность базового класса "Запись"
class Task < Post
  def initialize
    super # вызываем конструктор родителя

    # потом инициализируем специфичное для Задачи поле - дедлайн
    @due_date = Time.now
  end

  # Этот метод пока пустой, он будет спрашивать 2 строки - описание задачи и дату дедлайна
  def read_from_console
    puts 'Что надо сделать?'
    @text = STDIN.gets.chomp

    # спросим у пользователя, до какого числа ему нужно это сделать и подскажем формат, в котором нужно вводить дату
    puts 'К какому числу? Укажите дату в формате ДД.ММ.ГГГГ, например 12.05.2003'
    input = STDIN.gets.chomp

    # Для того, чтобы записть дату в удобном формате, воспользуемся методом parse класса Time
    @due_date = Date.parse(input)
  end

  # Массив из трех строк: дедлайн задачи, описание и дата создания
  def to_strings
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')} \n\r \n\r"

    deadline = "Крайний срок: #{@due_date}"

    return [deadline, @text, time_string]
  end

  def to_db_hash
    # вызываем родительский метод ключевым словом super и к хэшу, который он вернул
    # присоединяем прицепом специфичные для этого класса поля методом Hash#merge
    return super.merge(
      {
        'text' => @text,
        'due_date' => @due_date.to_s
      }
    )
  end

  # загружаем свои поля из хэш массива
  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для общих полей

    # теперь прописываем свое специфичное поле
    @due_date = Date.parse(data_hash['due_date'])
  end
end
