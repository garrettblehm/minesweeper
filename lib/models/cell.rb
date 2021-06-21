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

    private

    def shown?
      shown
    end
  end
end
