# frozen_string_literal: true

module Models
  class Cell < Base
    attr_accessor :value,
                  :shown,
                  :mine,
                  :row,
                  :column,
                  :top_left,
                  :top,
                  :top_right,
                  :left,
                  :right,
                  :bottom_left,
                  :bottom,
                  :bottom_right

    MASKED_VALUE = '*'
    MINE_VALUE = 'M'

    def initialize(row:, column:, value: 0, shown: false, mine: false)
      super
    end

    def reveal
      self.shown = true
      return if mine?
      return unless value.zero?

      adjacent_cells.each do |adjacent_cell|
        adjacent_cell.reveal unless adjacent_cell.shown?
      end
    end

    def set_mine
      self.mine = true
    end

    def print_position
      puts "mine: #{(column + 65).chr}#{row}"
    end

    def mine?
      mine
    end

    def to_s
      return MASKED_VALUE unless shown?

      mine? ? MINE_VALUE : value.to_s
    end

    def set_value
      count = 0
      adjacent_cells.each do |adjacent_cell|
        count += 1 if adjacent_cell.mine?
      end
      self.value = count
      true
    end

    def shown?
      shown
    end

    def adjacent_cells
      [
        top,
        bottom,
        left,
        right,
        top_left,
        top_right,
        bottom_left,
        bottom_right
      ].compact
    end
  end
end
