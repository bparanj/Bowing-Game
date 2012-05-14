module Bowling
  
  class Game
    attr_reader :score
    
    def initialize
      @score = 0  
    end
    
    def miss
      @score = 0
    end
    
    def spare
      @score += 10  
    end
    
    def strike
      @score += 10
    end
        
    def roll(pins)
      @score += pins
    end
  end
  
end