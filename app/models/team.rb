class Team < ApplicationRecord
  has_many :games_as_team_home, class_name: "Game", foreign_key: "team_home_id", dependent: :destroy
  has_many :games_as_team_away, class_name: "Game", foreign_key: "team_away_id", dependent: :destroy
end
