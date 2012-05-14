require 'spec_helper'
require 'bowling/game'

module Bowling
  describe Game do
    it "should return 0 for a miss" do
      game = Game.new
      game.miss
      
      game.score.should == 0
    end
  end  
end

