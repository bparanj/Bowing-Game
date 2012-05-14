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
      30.times { game.strike }
      
      game.score.should == 300
    end
  end  
end

