class Decider
    attr_accessor :board

    def initialize(board)
        @board = board
    end

    def decide
        return "up"
    end
end