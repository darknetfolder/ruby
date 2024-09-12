
choices = ["rock", "scissors", "paper"]

my_choice = ARGV[0]

choices = ["rock", "scissors", "paper"]
auto_choice = choices.sample # Случайный выбор

puts "Your choice: #{my_choice}"
puts "Computer choice: #{auto_choice}"

if my_choice == auto_choice
    puts "Dead heat!"
    elsif (my_choice == "rock" && auto_choice == "scissors") ||
          (my_choice == "scissors" && auto_choice == "paper") ||
          (my_choice == "paper" && auto_choice == "rock")
            puts "You won!"
    else
        puts "Computer won!"
end

