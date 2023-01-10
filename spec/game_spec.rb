require 'spec_helper'

RSpec.describe Game do
    games = CSV.read './data/games.csv', headers: true, header_converters: :symbol

    # let(:game){ Game.new( { game_id: "2012030221",season: "20122013",type: "Postseason",date_time: "5/16/13",away_team_id: "3",home_team_id: "6",away_goals: "2",home_goals: "3",venue: "Toyota Stadium",venue_link: "/api/v1/venues/null" } ) }

    let(:game){ Game.new(games) }

    describe "#initialize" do
      it 'exists' do
        expect(game).to be_a(Game)
      end

      it 'can read attributes' do
        expect(game.type).to eq("Postseason")
      end
    end

    describe 'compares total scores' do
      it 'finds total score' do
        expect(game.total_score).to be_a(Array)
      end
      
      it 'finds highest total score' do
        expect(game.highest_total_score).to eq(11)
      end
  
      it 'finds lowest total score' do
        expect(game.lowest_total_score).to eq(0)
      end
    end
end