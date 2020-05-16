class Game
    def initialize
        puts "Enter a size for the game:"
        @size = gets.chomp.to_i
        @hidden_board = Array.new (@size) {Array.new(@size, :N)}
        self.shuffler(@hidden_board)
        @board = Array.new (@size) {Array.new(@size, :N)}
        @misses_remaining = @board.length * 2
        @remaining = @board.length
    end

    def play
        self.display
        until win? || lose?
            puts "Enter a position"
            pos = gets.chomp.split(" ")
            row = pos.first.to_i
            col = pos.last.to_i
            if self.hit?(row, col)
                puts "You sunk my battleship!"
                @misses_remaining += 1
            end
            self.display
            @misses_remaining -= 1
            puts "#{@misses_remaining} remaining misses"
        end
        puts "GAME OVER"
    end

    def win?
        if @remaining == 0
            puts "YOU WIN!"
            true
        end
    end

    def lose?
        if @misses_remaining == 0
            puts "YOU LOSE!"
            true
        end
    end

    def hit?(row, col)
        @hidden_board.each_with_index do |s,hrow|
            s.each_with_index do |r,hcol|
                if @hidden_board[hrow][hcol] == :H && hrow == row && hcol == col
                    @board[hrow][hcol] = :H
                    @remaining -= 1
                    return true
                elsif @hidden_board[hrow][hcol] != :H && hrow == row && hcol == col
                    @board[hrow][hcol] = :X
                    return false                    
                end
            end
        end
    end

    def display
        puts "There are #{@remaining} hidden ships on the board."
        @board.each do |array|
            puts array.join(" ")
        end
        puts "#{"-" * @board.length * 2}"
    end


    def shuffler(board)
        board.each do |array|
            array[0] = :H
            array.shuffle!
        end
    end


end

Game.new.play
