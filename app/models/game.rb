class Game < ApplicationRecord
  belongs_to :team_home, class_name: "Team", foreign_key: "team_home_id", optional: true
  belongs_to :team_away, class_name: "Team", foreign_key: "team_away_id", optional: true
  has_many :bets, dependent: :destroy

  # validates :status, inclusion: { in: %w[pending open live finished] }

  def bettable?
    status == 'open'
    # start_time < DateTime.now
  end

  def self.current_matchday
    25
  end
end
