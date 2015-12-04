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
