module Players
  class Computer < Player

    def move(board)
      # 1st/2nd player, 1st move take bottom left corner
      if !board.taken?(7)
        move = "7"
      # 1st/2nd player, take middle
      elsif !board.taken?(5)
        move = "5"
      # if 1st player, 2nd move, take any edge
      elsif board.turn_count == 2
        move = [2, 4, 6, 8].detect{|input| !board.taken?(input)}
      # if 2nd player, 2nd move, take left or right edge
      elsif board.turn_count == 3
        move = [4, 6].detect{|input| !board.taken?(input)}
      else
        Game::WIN_COMBINATIONS.detect do |combo|
          # check if any win combo present
          if combo.select{|input| board.position(input) == token}.size == 2 && combo.any?{|input| board.position(input) == " "}
            move = combo.select{|input| !board.taken?(input)}.first
          # check and block other player win
          elsif combo.select{|input| board.position(input) != " " && board.position(input) != token}.size == 2 && combo.any?{|input| board.position(input) == " "}
            move = combo.select{|input| !board.taken?(input)}.first
          end
        end
        # take edges first, corners last
        move = [2, 4, 6, 8, 1, 3, 7, 9].detect{|input| !board.taken?(input)}
      end
      move
    end
  end
end
