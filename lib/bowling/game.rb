module Bowling
  
  class Game
    attr_reader :score
    attr_accessor :frame
    
    def initialize
      @score = 0  
      @score_card = []
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
        
    def roll(pins, frame = 1)
      @score += pins   
      update_score_card(pins, frame)  
    end
    
    def score_for_frame(n)
      @score_card[n - 1]
    end
    
    def score_total_upto_frame(n)
      @score_card.flatten.inject{|x, sum| x += sum}
    end
    
    private
    
    def update_score_card(pins, frame)
      if @score_card[frame - 1].nil?
        @score_card[frame - 1] = []
        @score_card[frame - 1][0] = pins
      else
        @score_card[frame - 1][1] = pins        
      end
    end
    
  end
  
end