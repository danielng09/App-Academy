#RPS
def rps(user_choice)
  puts "Type in Rock, Paper, or Scissors"
  computer_choice = { 0 => "Rock",
                      1 => "Paper",
                      2 => "Scissors"
                    }
  choice = rand(3)
  if user_choice == "Rock" || string == "Paper" || string == "Scissors"
    result = compare(user_choice, computer_choice[choice])
  else
    puts "Type in Rock, Paper, or Scissors"
  end
  "#{computer_choice[choice]},  #{result}"
end

def compare(user_choice, computer_choice)
  if user_choice == computer_choice
    "draw"
  elsif user_choice == "Rock"
    computer_choice == "Scissors" ? "Win" : "Lose"
  elsif user_choice == "Paper"
    computer_choice == "Rock" ? "Win" : "Lose"
  elsif user_choice == "Scissors"
    computer_choice == "Rock" ? "Lose" : "Win"
  end
end

#Mixology

def remix(mixed_drinks)
  mixer = []
  mixed_drinks.each do |x|
    mixer << x[1]
  end
  mixer.shuffle!
  mixed_drinks.each_with_index do |x, index|
    x[1] = mixer[index]
  end
  mixed_drinks
end
