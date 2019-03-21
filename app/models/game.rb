class Game < ApplicationRecord
  belongs_to :team_one, class_name: "Team", foreign_key: "team_one_id", optional: true
  belongs_to :team_two, class_name: "Team", foreign_key: "team_two_id", optional: true
  has_many :bets, dependent: :destroy

  validates :status, inclusion: { in: %w[coming live finished] }

  def bettable?
    start_time < DateTime.now
  end

  def self.current_matchday
    25
  end
end
