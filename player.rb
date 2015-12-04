require_relative 'move_history'

class Player
  attr_accessor :hand, :score
  attr_reader :name

  def initialize
    puts "Please enter your name:"
    @name = gets.chomp
    @score = 0
  end

  def pick_hand
    begin
      puts "Enter you move(r,p,s):"
      input = gets.chomp.downcase
      self.hand = Move.new(input)
    end until Move::CHOICES.keys.include?(input)
  end
end
