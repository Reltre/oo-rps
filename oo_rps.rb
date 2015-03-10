class Move
  include Comparable
  
  attr_reader :value

  def initialize(v)
    @value = v
  end
  
  def <=>(other)
    if self.value == other.value
      0
    elsif (self.value == 's' && other.value == 'p') || 
        (self.value.ord < other.value.ord)
      1
    else
      -1
    end   
  end
end

class Player
  attr_accessor :hand
  CHOICES = {'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors'}

  def pick_hand
    self.hand = Move.new(CHOICES.keys.sample)
  end
end

class Human < Player
 
  attr_reader :name
 
  def initialize(name)
    puts "Please enter your name:"
    @name = name
  end
  

  def pick_hand
    begin
      puts "Enter you move(r,p,s)"
      input = gets.chomp.downcase
      self.hand = Move.new(input)
    end until CHOICES.keys.include?(input)
  end
end


class RockPaperScissors
  attr_reader :human, :computer
  
  def initialize(human,computer)
    @human = human
    @computer = computer
  end
  
  def play
    puts "Welcome to this game of Rock,Paper,Scissors!\n"
    human.pick_hand
    computer.pick_hand
    compare_hands
  end

  def play_again?
    puts "Would you like to play again?"   
    answer = gets.chomp.downcase
    answer == 'yes' || answer == 'yea' || answer == 'y' ? true : false
  end

  def game_results(winning_choice)
    if winning_choice == 's'
      puts "Scissors cuts paper."
    elsif winning_choice == 'r'
      puts "Rock smashes scissors."
    else
      puts "Paper wraps rock."
    end
  end

  def display_hands
    player_move = Player::CHOICES[human.hand.value]
    computer_move = Player::CHOICES[computer.hand.value]
    print "#{human.name} chose #{player_move} " 
    print "and the Computer chose #{computer_move}\n"
  end

  def compare_hands
    display_hands
    if human.hand == computer.hand
      puts "The game is a tie"
    elsif human.hand < computer.hand
      game_results(computer.hand.value)
      puts "The Computer Wins"
    else
      game_results(human.hand.value)
      puts "#{human.name} wins!"
    end
  end
end


computer = Player.new
puts "Please enter your name."
human = Human.new(gets.chomp)
game = RockPaperScissors.new(human, computer)

begin
game.play
end while game.play_again?
puts "Thanks For Playing"

