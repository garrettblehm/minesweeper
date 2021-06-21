module Controllers
  class Game
    attr_accessor :board, :size

    def initialize(size = 3)
      @size = size
      @board = Models::Board.new(size)
    end

    def start
      # Setup game
      finished = false
      board.set_mines
      board.set_values
      puts board.to_s

      until finished
        # Get move from user
        puts
        puts 'Enter cell "A0":'
        move = gets

        # Reveal move and print board
        column, row = extract_args(move.chomp)
        board.reveal_cell(sanitize_row(row), sanitize_column(column))
        puts board.to_s
        puts "Last move: #{move}"

        # Check for win or loss
      end
    end

    private

    def extract_args(input)
      [input[0], input[1..]]
    end

    def sanitize_row(row)
      row.to_i
    end

    def sanitize_column(column)
      column.upcase.ord - 65
    end
  end
end
