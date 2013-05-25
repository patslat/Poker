describe Game do
  subject(:game) { Game.new(4) }
  
  it "should initialize with up to 4 players" do
    game.players.length.should == 4
  end
end