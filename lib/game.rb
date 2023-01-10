require 'csv'

class Game
  attr_reader :game_id,
              :season,
							:type,
							:date_time,
							:away_team_id,
							:home_team_id,
							:away_goals,
							:home_goals,
							:venue,
							:venue_link

	def initialize(info)
			@game_id = info[:game_id]
			@season = info[:season]
			@type = info[:type]
			@date_time = info[:date_time]
			@away_team_id = info[:away_team_id]
			@home_team_id = info[:home_team_id]
			@away_goals = info[:away_goals]
			@home_goals = info[:home_goals]
			@venue = info[:venue]
			@venue_link = info[:venue_link]
	end

	def self.all_games(location)
		games = []
		CSV.foreach location, headers: true, header_converters: :symbol do |row|
			games << Game.new(row)
		end
		games
	end
end