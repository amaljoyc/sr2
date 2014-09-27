# University of Washington, Programming Languages, Homework 6, hw6runner.rb

class MyTetris < Tetris
  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_clockwise + @board.rotate_clockwise})
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
end

class MyPiece < Piece
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
                   rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
                   [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
                   [[0, 0], [0, -1], [0, 1], [0, 2]]],
                   rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
                   rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
                   rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
                   rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
                   rotations([[0, 0], [1, 0], [0, 1], [1, 1], [0, 2]]), #new1
                   [[[0, 0], [-1, 0], [1, 0], [2, 0], [-2, 0]], # new2
                   [[0, 0], [0, -1], [0, 1], [0, 2], [0, -2]]],
                   rotations([[0, 0], [0, 1], [1, 0]])] # new3

  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  def get_piece_size
    @all_rotations[0].size
  end
end

class MyBoard < Board
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
  end

  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    size = @current_block.get_piece_size
    size -= 1
    (0..size).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
end