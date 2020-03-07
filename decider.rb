class Decider
    attr_accessor :board, :snake

    def initialize(board, snake)
        @board = board
        @snake = snake
    end

    def decide
        return "up"
    end
end