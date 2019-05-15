class Game < ApplicationRecord
  belongs_to :team_home, class_name: "Team", foreign_key: "team_home_id", optional: true
  belongs_to :team_away, class_name: "Team", foreign_key: "team_away_id", optional: true
  has_many :bets, dependent: :destroy

  # validates :status, inclusion: { in: %w[pending open live finished] }

  def self.current_matchday
    37
  end

  def self.opened_matchdays
    Game.distinct.where(status: 'open').pluck(:matchday).sort
  end
end
