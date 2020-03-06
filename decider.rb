class Decider
    attr_accessor :board

    def initialize(board, player_snake)
        @board = board
    end

    def decide
        return "up"
    end
end