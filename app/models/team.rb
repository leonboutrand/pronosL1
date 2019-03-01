class Team < ApplicationRecord
  has_many :games_as_p_one, class_name: "Game", foreign_key: "team_one_id", dependent: :destroy
  has_many :games_as_p_two, class_name: "Game", foreign_key: "team_two_id", dependent: :destroy
end
