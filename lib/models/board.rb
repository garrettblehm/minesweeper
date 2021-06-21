module Models
  class Board < Base
    attr_accessor :board, :size

    def initialize(size)
      @size = size
      @board = Array.new(size) { |row| Array.new(size) { |column| Cell.new(row: row, column: column) } }
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          # Need to add corners
          cell.top = row_index > 1 ? board[row_index - 1][column_index] : nil
          cell.bottom = row_index < size - 1 ? board[row_index + 1][column_index] : nil
          cell.left = column_index > 1 ? board[row_index][column_index - 1] : nil
          cell.right = column_index < size - 1 ? board[row_index][column_index + 1] : nil
        end
      end
    end

    def reveal_cell(row, column)
      board[row][column].reveal
    end

    def set_mines(count = 5)
      cells = all_cells.sample(count)

      cells.each(&:set_mine)

      cells.each do |cell|
        cell.print_position
      end
    end

    def set_values; end

    def to_s
      output = offset
      output << alpha_bar
      output << print_board
      output
    end

    private

    ALPHABET_ARRAY = ('A'..'Z').to_a.freeze

    def all_cells
      cells = []
      board.each do |row|
        row.each do |cell|
          cells << cell
        end
      end
      cells
    end

    def offset
      '    '
    end

    def alpha_bar
      output = ''
      size.times { |s| output << num_to_char(s) + ' ' }
      output << newline + offset
      size.times { output << '-' + ' ' }
      output << newline
      output
    end

    def num_to_char(num)
      ALPHABET_ARRAY[num].to_s
    end

    def newline
      "\n"
    end

    def print_board
      output = ''
      board.each_with_index do |row, index|
        output << num_prefix(index)
        row.each do |cell|
          output << cell.to_s + ' '
        end
        output << newline
      end
      output
    end

    def num_prefix(num)
      return num.to_s + ':' + '  ' if num < 10

      num.to_s + ':' + ' '
    end
  end
end
