class Employee
    attr_accessor :name, :rang, :money
  
    def initialize(name, rang, money)
      @name = name
      @rang = rang
      @money = money
    end
  
    def increase_money(percentage)
      @money *= (1 + percentage / 100.0)
    end
  end
  
  # Отримання даних 
  print "Введіть ім'я: "
  name = gets.chomp
  print "Введіть посаду: "
  rang = gets.chomp
  print "Введіть зарплату: "
  money = gets.chomp.to_f
  
  employee = Employee.new(name, rang, money)

  puts "Зарплата до підвищення: #{employee.money}"
  print "Введіть відсоток для підвищення зарплати: "
  employee.increase_money(gets.chomp.to_f)
  puts "Ім'я: #{employee.name}, Посада: #{employee.rang}"
  puts "Зарплата після підвищення: #{employee.money}"
  