require 'spec_helper'
require 'bowling/game'

module Bowling
  describe Game do

    it "for a strike, the bowler gets the 10 + the total of the next two roll to that frame" do
      game = Game.new
      game.strike

      game.roll(7)
      game.roll(5)

      game.score.should == 22
    end

    it "should return 300 for a perfect game" do
      game = Game.new
      repeat(30) { game.strike } 

      game.score.should == 300
    end

    it "should return a score of 8 for first hit of 6 pins and the second hit of 2 pins for the first frame" do
      game = Game.new
      game.frame = 1

      game.roll(6)
      game.roll(2)

      game.score.should == 8
    end

    it "should return the score for a given frame to allow display of score" do
      game = Game.new

      game.roll(6)
      game.roll(2)

      game.score_for_frame(1).should == [6, 2]      
    end
    # This test passed without failing. Gave me confidence it can handle scoring multiple frames
    it "should return the total score for first two frames of a game" do
      g = Game.new
      # Frame #1
      g.roll(6)
      g.roll(2)
      # Frame #2
      g.roll(7, 2)
      g.roll(1,2)

      g.score.should == 16
    end

    context "Bonus Scoring : All 10 pins are hit on the first ball roll. The Strike" do
      it "Rolling a strike : All 10 pins are hit on the first ball roll. Score is 10 pins + Score for the next two ball rolls" do
        g = Game.new
        # Frame 1
        g.roll(6)
        g.roll(2)
        # Frame 2
        g.roll(10,2)
        # Frame 3
        g.roll(9, 3)
        g.roll(0, 3)

        g.score.should == (8 + 10 + 9 + 0)        
      end

      it "should return the score of a given frame by adding to the running total + 10 + the score for next two balls for a strike"  do
        g = Game.new
        g.frame_set do
          # Frame 1
          g.roll(6)
          g.roll(2)
          # Frame 2
          g.roll(7, 2)
          g.roll(1, 2)
          # Frame 3        
          g.roll(10,3)
          # Frame 4
          g.roll(9, 4)
          g.roll(1, 4)
        end
        # score_total_upto_frame(3) should be 36
        g.score_total_upto_frame(3).should == (6 + 2 + 7 + 1 + 10 + 9 + 1)
      end
      
      it "should return the total score of the game that includes a strike" do
        g = Game.new
        
        g.frame_set do
          g.roll(6)
          g.roll(2)

          g.roll(7,2)
          g.roll(1,2)          
        
          g.roll(10,3)

          g.roll(9,4)
          g.roll(1,4)          
        end
        # g.score_total_upto_frame(4) is 46
        g.score_total_upto_frame(4).should == (6 + 2 + 7 + 1 + 10 + 9 + 1 + 9 + 1)
      end
      
    end
    
    context "Bonus Scoring : All 10 pins are hit on the second ball roll. The Spare" do
      it "should return the score that is ten pins + number of pins hit on the next ball roll" do
        g = Game.new
        
        g.frame_set do
          g.roll(6)
          g.roll(2)
          
          g.roll(7,2)
          g.roll(1,2)
          
          g.roll(10, 3)
          
          g.roll(9,4)
          g.roll(0,4)
          # A spare happens on the fifth frame
          g.roll(8,5)
          g.roll(2,5)
          
          g.roll(1, 6)
          
        end 
        # p g.score_total_upto_frame(5) -- 55
        g.score_total_upto_frame(5).should == (6 + 2) + (7 + 1) + (10 + 9 + 0) + (9 + 0) + (8 + 2 + 1)          
      end        
    end
    
  end  
end

