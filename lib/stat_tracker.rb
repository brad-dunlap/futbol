require 'csv'
require_relative './league'

class StatTracker
  attr_reader :league

  def self.from_csv(locations)
    data = {}
    locations.each do |key, csv_file_path|
      data[key] = CSV.open(csv_file_path, headers: true, header_converters: :symbol)
      data[key] = data[key].to_a.map do |row|
        row.to_h
      end
    end
    self.new(:futbol, data)
  end

  def initialize(league_name, data)
    @league = League.new(league_name, data)
  end

  def highest_total_score
    max_total_score = 0
    require 'pry-byebug'; require 'pry'; binding.pry
    @league.seasons.max_by do |season|
      max_game = season.games.max_by do |game|
        game.info[:home_goals].to_i + game.info[:away_goals].to_i
      end
      max_score = max_game.info[:home_goals].to_i + max_game.info[:away_goals].to_i
      if max_score > max_total_score
        max_total_score = max_score
      end
    end
    max_total_score
  end

  def lowest_total_score
    @league.seasons.min_by do |season|
      season[:games].min_by do |game|
        game[:home_goals] + game[:away_goals]
      end
    end
  end

  def percentage_home_wins

  end

  def percentage_visitor_wins

  end

  def percentage_ties

  end

  def count_of_games_by_season

  end

  def average_goals_per_game

  end

  def average_goals_by_season

  end

  def count_of_teams

  end

  def best_offense

  end

  def worst_offense

  end

  def highest_scoring_visitor

  end

  def lowest_scoring_visitor

  end

  def lowest_scoring_home_team

  end

  def winningest_coach

  end

  def worst_coach

  end

  def most_accurate_team

  end

  def least_accurate_team

  end

  def most_tackles

  end

  def fewest_tackles

  end
end

game_path = './spec/fixtures/games_sample.csv'
team_path = './data/teams.csv'
game_teams_path = './spec/fixtures/game_teams_sample.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
