class MoveHistory
  attr_reader :player_moves

  def initialize
    @player_moves = []
    @computer_moves = []
  end

  def update(participant)
    @player_moves << participant.hand.value if participant.instance_of? Player
    @computer_moves << participant.hand.value if participant.instance_of? Computer
  end
end
