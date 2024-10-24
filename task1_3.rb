begin
  raise 'це виняток'
rescue RuntimeError => exception
  puts "Виняток оброблено: #{exception.inspect}"
  # => "Виняток оброблено: #<RuntimeError: це виняток>"
ensure
  puts "Цей код виконується завжди, незалежно від того, виникла помилка чи ні."
end

puts "Це повідомлення *буде* виведене."

while умова
  # код який виконується поки умова є правильною
end
