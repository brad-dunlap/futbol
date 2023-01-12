require_relative 'spec_helper'

RSpec.describe StatTracker do

  let(:stat_tracker) { 
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    StatTracker.from_csv(locations) 
  }
    
  describe '#initialize' do
	  it 'exists' do
      expect(stat_tracker).to be_a StatTracker
	  end

    it 'has attributes' do
      expect(stat_tracker.game_team_collection).to be_a(Array)
      expect(stat_tracker.game_collection).to be_a(Array)
      expect(stat_tracker.team_collection).to be_a(Array)
    end
  end 

  describe 'Game Statistics' do
    context '#highest_total_score' do
      it 'finds highest total score' do
        expect(stat_tracker.highest_total_score).to eq(11)
      end
    end

    context "#lowest_total_score" do
      it 'finds lowest total score' do
        expect(stat_tracker.lowest_total_score).to eq(0)
      end
    end

    context '#percentage_home_wins' do
      it "checks percentage of wins/ties" do
        expect(stat_tracker.percentage_home_wins).to eq 0.44
      end
    end

    context '#percentage_visitor_wins' do
      it "finds percentage of games that a visitor has won (rounded to the nearest 100th)" do
        expect(stat_tracker.percentage_visitor_wins).to eq 0.36
      end
  
    context "#percentage_ties" do
      it "find percentage of games that has resulted in a tie (rounded to the nearest 100th)" do
        expect(stat_tracker.percentage_ties).to eq 0.20
      end
    end
    
    context '#count_of_games_by_season' do
      it 'is a hash' do
        expect(stat_tracker.count_of_games_by_season).to be_a(Hash)
      end

      it 'can return number of games by season' do

        expected_hash = {
          "20122013"=>806, 
          "20162017"=>1317,
          "20142015"=>1319,
          "20152016"=>1321,
          "20132014"=>1323,
          "20172018"=>1355
        }

        expect(stat_tracker.count_of_games_by_season).to eq(expected_hash)
        expect(stat_tracker.count_of_games_by_season["20122013"]).to eq(806)

      end
    end

    context '#average_goals_per_game' do
      it 'is a float' do
        expect(stat_tracker.average_goals_per_game).to be_a(Float)
      end
  
      it 'can find average' do
        expect(stat_tracker.average_goals_per_game).to eq(4.22)
      end
    end

    context '#average_goals_by_season' do
      it 'is a Hash' do
        expect(stat_tracker.average_goals_by_season).to be_a(Hash)
      end
  
      it 'can find average for season' do
        expected_hash = {
          "20122013"=>4.12,
          "20162017"=>4.23,
          "20142015"=>4.14,
          "20152016"=>4.16,
          "20132014"=>4.19,
          "20172018"=>4.44
        }
  
        expect(stat_tracker.average_goals_by_season["20122013"]).to eq(4.12)
        expect(stat_tracker.average_goals_by_season).to eq(expected_hash)
      end
    end
  end

  describe 'League Statistics' do
    context '#count_of_teams' do
      it 'is a integer' do
        expect(stat_tracker.count_of_teams).to be_a(Integer)
      end

      it 'can count # of teams' do
        expect(stat_tracker.count_of_teams).to eq(32)
      end
    end

    context '#best_offense' do
      it 'is a string' do
        expect(stat_tracker.best_offense).to be_a(String)
      end
  
      it 'returns team with highest average across all seasons' do
        expect(stat_tracker.best_offense).to eq("Reign FC")
      end
    end
    
    context '#worst_offense' do
      it 'is a string' do
        expect(stat_tracker.worst_offense).to be_a(String)
      end
      
      it 'returns team with lowest average across all seasons' do
        expect(stat_tracker.worst_offense).to eq("Utah Royals FC")
      end
      
    end

	  context '#highest_scoring_visitor' do
      it "returns name of the team with the highest average score per away game across all seasons" do
        expect(stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
      end
    end
    
    context '#highest_scoring_home_team'
      it "returns name of the team with the highest average score per home game across all seasons" do
        expect(stat_tracker.highest_scoring_home_team).to eq "Reign FC"
      end
    end

  	context "#lowest_scoring_visitor" do
      it 'Name of the team with the lowest average score per game across all seasons when they are a visitor.' do
    	  expect(stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
      end
  	end

    context "#lowest_scoring_home_team" do
      it 'Name of the team with the lowest average score per game across all seasons when they are at home.'
        expect(stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
      end
    end
	end

  describe "Season Statistics" do
    context "#winningest_coach" do
      it 'returns a string of the coach with the best win percentage for the season' do
        expect(stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
        expect(stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
      end
    end

    context "#worst_coach" do
      it "returns a string of the coach with the worst win percentage for the season" do
        expect(stat_tracker.worst_coach("20132014")).to eq("Peter Laviolette")
        expect(stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
      end
    end

    context '#most_accurate_team' do
      it "returns a string of the Team with the best ratio of shots to goals for the season" do
        expect(stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
        expect(stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
      end
    end
    
    context '#least_accurate_team' do
      it "returns a string of the Team with the best ratio of shots to goals for the season" do
        expect(stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
        expect(stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
      end
    end

    context '#most_tackles' do
      it "returns a string of the Team with the most tackles in the season" do
        expect(stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
        expect(stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
      end
    end
    context "#fewest_tackles" do
      it "returns a string of the Team with the least tackles in the season" do
        expect(stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
        expect(stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
      end
    end
	end

  describe "Team Statistics" do
    context '#team_info' do
      it 'is a hash' do
        expect(stat_tracker.team_info("id")).to be_a(Hash)
      end

      it 'returns a hash with key/value pairs of the teams attributes' do

      team = {
        "team_id" => "18",
        "franchise_id" => "34",
        "team_name" => "Minnesota United FC",
        "abbreviation" => "MIN",
        "link" => "/api/v1/teams/18"
      }

      expect(stat_tracker.team_info("18")).to eq(team)
      end
    end

    describe 'returns season with the highest win percentage for a team.' do
      it 'is a string' do
        expect(stat_tracker.best_season("6")).to be_a(String)
      end

      it "#best_season" do
        expect(stat_tracker.best_season("6")).to eq "20132014"
      end
    end
  end

  describe 'returns season with the lowest win percentage for a team.' do
    it 'is a string' do
      expect(stat_tracker.worst_season("6")).to be_a(String)
    end

    it "#worst_season" do
    expect(stat_tracker.worst_season("6")).to eq "20142015"
    end
  end

  describe 'returns average win percentages of all games for a team' do
    it "#average_win_percentage" do
      expect(stat_tracker.average_win_percentage("6")).to eq 0.49
    end
  end

	describe 'determines goals per game by team' do
    it "#most_goals_scored" do
      expect(stat_tracker.most_goals_scored("18")).to eq 7
    end

    it "#fewest_goals_scored" do
      expect(stat_tracker.fewest_goals_scored("18")).to eq 0
    end
	end

  describe "#favorite_opponent / #rival" do
    context "#favorite_opponent" do
      it 'shows name of the opponent that has the lowest win percentage against the given team' do
        expect(stat_tracker.favorite_opponent("18")).to eq "DC United"
      end
    end
  
    context "#rival" do
      it 'shows name of the opponent that has the highest win percentage against the given team' do
        expect(stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
      end
    end
  end

end