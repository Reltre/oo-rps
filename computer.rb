require 'pry'

class Computer
  attr_accessor :hand, :score
  R2D2 = {'r' => 0.60, 's' => 0.0, 'p' => 0.40 }
  WALLE = {'r' => 1.0, 's' => 0.0, 'p' => 0.0 }

  def initialize
    @score = 0
    @personality = [R2D2, WALLE].sample
  end

  def pick_hand(history)
    computer_move = weigh_move_choices(history)

    self.hand =
      computer_move ? Move.new(computer_move) : Move.new(choice_by_personality)
  end

  def weigh_move_choices(history)
    return nil if history.player_moves.size == 0
    rock_count = history.player_moves.select{ |move| move == 'r' }.size
    paper_count = history.player_moves.select{ |move| move == 'p' }.size
    scissors_count = history.player_moves.select{ |move| move == 's' }.size
    return nil if rock_count == paper_count && paper_count == scissors_count
    highest_weight = [rock_count, paper_count, scissors_count].max
    return 's' if highest_weight == 'p'
    return 'r' if highest_weight == 's'
    return 'p' if highest_weight == 'r'
  end

  private

  def choice_by_personality
    value = rand
    @personality.values.each do |weight|
      result = value - weight
      return @personality.key(weight) if result <= 0
    end
  end
end
