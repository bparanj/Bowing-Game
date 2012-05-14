module Bowling
  
  class Game
    attr_reader :score
    
    def miss
      @score = 0
    end
  end
  
end