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
      @score_card.take(n).flatten.inject{|x, sum| x += sum}
    end
    
    def frame_set
      yield 
      update_strike_score
      update_spare_score
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
    
    def update_strike_score
      strike_index = 100

      @score_card.each_with_index do |e, i|
       # Update the strike score only once
       if e.include?(10) and (e.size == 1)
         strike_index = i
       end
      end

      last_element_index = (@score_card.size - 1)
      if strike_index < last_element_index
        @score_card[strike_index] +=  @score_card[strike_index + 1]
      end
    end
    
    def update_spare_score
      spare_index = 100

      @score_card.each_with_index do |e, i|
        # Skip strike score
        unless e.include?(10)
          if (e.size == 2) and (e.inject(:+) == 10)
            spare_index = i
          end
        end
      end
      
      last_element_index = (@score_card.size - 1)
      if spare_index < last_element_index
        @score_card[spare_index] +=  [@score_card[last_element_index][0]]
      end
    end
  end
  
end