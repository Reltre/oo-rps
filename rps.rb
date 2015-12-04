require_relative 'computer'
require_relative 'player'
require_relative 'move'
require_relative 'move_history'

class RockPaperScissors
  attr_reader :player, :computer, :history

  def initialize
    @player = Player.new
    @computer = Computer.new
    @history = MoveHistory.new
  end

  def play
    puts "Welcome to this game of Rock,Paper,Scissors!\n"
    player.pick_hand
    computer.pick_hand(history)
    record_move_history
    display_hands
    compare_hands
    show_score
    stop_game_if_score_is_ten
    play_again
  end

  def record_move_history
    @history.update player
    @history.update computer
  end

  def play_again
    puts "Would you like to play again?"
    answer = gets.chomp.downcase
    play if ['yes','yea','y'].include?(answer)
  end

  def stop_game_if_score_is_ten
    if player.score == 10
      puts "You won the game with 10 points!"
    elsif computer.score == 10
      puts "The computer won the game with 10 points, better luck next time."
    end
    exit if player.score == 10 || computer.score == 10
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

  def show_score
    puts '-' * 10
    puts "Player Score: #{player.score}    |    Computer Score: #{computer.score}"
  end

  def display_hands
    player_move = Move::CHOICES[player.hand.value]
    computer_move = Move::CHOICES[computer.hand.value]
    print "#{player.name} chose #{player_move} "
    print "and the Computer chose #{computer_move}.\n"
  end

  def compare_hands
    if player.hand == computer.hand
      puts "The game is a tie."
    elsif player.hand < computer.hand
      game_results(computer.hand.value)
      computer.score += 1
      puts "The Computer Wins."
    else
      game_results(player.hand.value)
      player.score += 1
      puts "#{player.name} wins!"
    end
  end
end

RockPaperScissors.new.play
puts "Thanks For Playing."
