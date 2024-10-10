# маркировка нарезанных кусков торта
def cut(ar_cake, x, y, width, height)
  (y...(y + height)).each do |i|
    (x...(x + width)).each { |j| ar_cake[i][j] = "*" }
  end
  ar_cake
end

# Transform array into string form
def arr_to_string(rectangle_form)
  result = ""
  rectangle_form.each do |i|
    i.each { |j| result += j }
    result += "\n"
  end
  result
end

# Этот метод возвращает хэш с индексами верхнего левого доступного места (куска) в торте.
def find_first_not_cut_spot(ar_cake)
  (0...ar_cake.size).each do |i|
    (0...ar_cake[i].size).each { |j| return { y: i, x: j } if ar_cake[i][j] != "*" }
  end
  nil
end

# возможно ли отрезать какой-либо фрагмент
def slice_valid(ar_cake, x, y, width, height)
  return nil if (x + width) > ar_cake[0].size || (y + height) > ar_cake.size # check if slice is not out of cake ranges (form)
  slice = ar_cake.slice(y, height).map { |i| i.slice(x, width) }
  str_slice = arr_to_string(slice)
  return nil if str_slice.include?("*") || str_slice.count("o") != 1

  str_slice
end

# рекурсивный поиск возможных решений
def searching(ar_cake, slices, size, all_solutions)
  position = find_first_not_cut_spot(ar_cake)
  if position.nil?
    all_solutions << slices.dup
    return
  end

  slice_width = size
  while slice_width > 0
    slice_height = 1
    while slice_height <= size
      if slice_width * slice_height == size
        slice = slice_valid(ar_cake, position[:x], position[:y], slice_width, slice_height)
        unless slice.nil?
          new_slices = slices.dup.push(slice)
          new_ar_cake = ar_cake.map(&:dup)
          new_ar_cake = cut(new_ar_cake, position[:x], position[:y], slice_width, slice_height)
          searching(new_ar_cake, new_slices, size, all_solutions)
        end
      end
      slice_height += 1
    end
    slice_width -= 1
  end
end

# имеет ли кусок форму прямоугольника? правильное количество изюма в куске ?
def cake_valid?(cake)
  return false if cake.count("o") <= 1 || cake.count("o") >= 10

  array_cake = cake.split("\n")
  cake_width = array_cake[0].size
  array_cake.each do |i|
    return false unless i.size == cake_width
  end
  true
end

cake = ".o.o..\n......\n....o.\n..o..."

unless ARGV.empty?
  puts "Taking cake from input."
  cake.clear
  ARGV.each { |i| cake += i + "\n" }
end

puts "cake =\n#{cake}"

raisins = cake.count("o")
puts "Amount of raisins: #{raisins}"

unless cake_valid?(cake)
  puts "Sorry, your cake doesn't have a rectangular form or the amount of raisins is out of range (1;10)"
  exit
end

puts "Trying to cut the cake..."

# торт из строки в 2D-массив для упрощения манипуляций
array_cake = cake.split("\n").map { |i| i.split("") }
slice_size = (array_cake.size * array_cake[0].size) / raisins
puts "Wanted size of slices: #{slice_size}"

all_solutions = []
searching(array_cake, [], slice_size, all_solutions)

if all_solutions.empty?
  puts "Can't cut the cake properly"
else
  # Выбор решения с самым широким первым элементом
  valid_solutions = all_solutions.select { |solution| solution.all? { |slice| slice.count("o") == 1 } }
  best_solution = valid_solutions.max_by { |solution| solution.first.lines.first.strip.size }
  puts "Result:"
  best_solution.each { |i| puts "\n" + i }
  puts "Your slices: #{best_solution}"
end