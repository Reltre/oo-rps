class Move
  include Comparable
  
  attr_reader :value
  CHOICES = {'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors'}

  def initialize(v = CHOICES.keys.sample)
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

class Computer
  attr_accessor :hand
  
  def pick_hand
    self.hand = Move.new
  end
end

class Player
  attr_accessor :hand
  attr_reader :name
 
  def initialize
    puts "Please enter your name:"
    @name = gets.chomp
  end
  

  def pick_hand
    begin
      puts "Enter you move(r,p,s)"
      input = gets.chomp.downcase
      self.hand = Move.new(input)
    end until Move::CHOICES.keys.include?(input)
  end
end


class RockPaperScissors
  attr_reader :player, :computer
  
  def initialize
    @player = Player.new
    @computer = Computer.new
  end
  
  def play
    puts "Welcome to this game of Rock,Paper,Scissors!\n"
    player.pick_hand
    computer.pick_hand
    compare_hands
  end

  def play_again?
    puts "Would you like to play again?"   
    answer = gets.chomp.downcase
    ['yes','yea','y'].include?(answer) 
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
    player_move = Move::CHOICES[player.hand.value]
    computer_move = Move::CHOICES[computer.hand.value]
    print "#{player.name} chose #{player_move} " 
    print "and the Computer chose #{computer_move}.\n"
  end

  def compare_hands
    display_hands
    if player.hand == computer.hand
      puts "The game is a tie."
    elsif player.hand < computer.hand
      game_results(computer.hand.value)
      puts "The Computer Wins."
    else
      game_results(player.hand.value)
      puts "#{player.name} wins!"
    end
  end
end

game = RockPaperScissors.new

begin
  game.play
end while game.play_again?
puts "Thanks For Playing."

