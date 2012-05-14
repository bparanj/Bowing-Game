require 'spec_helper'
require 'bowling/game'

module Bowling
  describe Game do
    it "should return 0 for a miss (for not knocking down any pins)" do
      game = Game.new
      game.miss
      
      game.score.should == 0
    end
    
    it "should return 10 for a strike (for knocking down all ten pins)" do
      game = Game.new
      game.strike
      
      game.score.should == 10
    end
    
    it "should return 10 for a spare (Remaining pins left standing after the first roll are knocked down on the second roll)" do
      game = Game.new
      game.roll(7)
      game.roll(3)
      
      game.roll(2)
      
      game.score.should == 12
    end

    it "for a spare the bowler gets the 10 + the total number of pins knocked down on the next roll only" do
      game = Game.new
      game.spare
      
      game.roll(2)
      
      game.score.should == 12
    end
    
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
      
      game.score_for(1).should == [6, 2]      
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
    
  end  
end

