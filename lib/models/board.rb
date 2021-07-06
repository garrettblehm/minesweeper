# frozen_string_literal: true

module Models
  class Board < Base
    attr_accessor :board, :size, :mine_cells

    def initialize(size)
      @size = size
      @board = Array.new(size) { |row| Array.new(size) { |column| Cell.new(row: row, column: column) } }
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          has_top = row_index > 0
          has_bottom = row_index < size - 1
          has_left = column_index > 0
          has_right = column_index < size - 1

          top_row_index = row_index - 1
          bottom_row_index = row_index + 1
          left_column_index = column_index - 1
          right_column_index = column_index + 1

          cell.top = has_top ? board[top_row_index][column_index] : nil
          cell.bottom = has_bottom ? board[bottom_row_index][column_index] : nil
          cell.right = has_right ? board[row_index][right_column_index] : nil
          cell.left = has_left ? board[row_index][left_column_index] : nil

          cell.top_right = has_top && has_right ? board[top_row_index][right_column_index] : nil
          cell.top_left = has_top && has_left ? board[top_row_index][left_column_index] : nil
          cell.bottom_right = has_bottom && has_right ? board[bottom_row_index][right_column_index] : nil
          cell.bottom_left = has_bottom && has_left ? board[bottom_row_index][left_column_index] : nil
        end
      end
    end

    def reveal_cell(row, column)
      board[row][column].reveal
    end

    def set_mines(count = 5)
      mine_cells = all_cells.sample(count)

      mine_cells.each(&:set_mine)

      mine_cells.each do |mine_cell|
        mine_cell.print_position
      end
    end

    def set_values
      all_cells.each(&:set_value)
    end

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
      +'    '
    end

    def alpha_bar
      output = +''
      size.times { |s| output << "#{num_to_char(s)} " }
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
      output = +''
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
