def factorial(x)
    return 1 if x == 0  # якщо n дорівнює 0, факторіал дорівнює 1
    x * factorial(x - 1) # Рекурсія x  факторіал числа (x-1)
  end
  
  puts factorial(10) # Виклик функції для числа 5
  