class Game

  attr_accessor :board, :player_1, :player_2


  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

def current_player
  if @board.turn_count.even?
    player_1
  else player_2
 end
end

  def over?
    won? || draw? || @board.full?
  end

  def won?
  WIN_COMBINATIONS.find do |combo|
    @board.cells[combo[0]] == @board.cells[combo[1]] &&
    @board.cells[combo[1]] == @board.cells[combo[2]] &&
    @board.taken?(combo[0]+1)
    end
  end

  def draw?
    !won? && @board.full?
  end

  def winner
    if won?
     @board.cells[won?[1]]
   elsif draw?
     return nil
    end
  end

  def turn
    player = current_player
    current_move = player.move(@board)
    if @board.valid_move?(current_move)
      @board.update(current_move,player)
      @board.display
    else
      turn
    end
  end


  def play
     while !over?
    turn
    end
    if won?
        puts "Congratulations #{winner}!"
      else
        puts "Cat's Game!"
      end
  end

  def wargames
    x_counter = 0
    o_counter = 0
    draw_counter = 0
    100.times do
      Game.new(player_1 = Players::Computer.new("X"), player_2 = Players::Computer.new("O"), board = Board.new).play
        if winner == "X"
          x_counter += 1
        elsif winner == "O"
          o_counter += 1
        # end
      else draw_counter += 1
      end
    end
    puts "X won #{x_counter} times"
    puts "O won #{o_counter} times"
    puts "There were #{draw_counter} draws"
  end


end
