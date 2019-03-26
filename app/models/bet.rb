class Bet < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validate :game_bettable?, on: :create
  validates :game_id, uniqueness: { scope: :user_id }
  validates :score_home, :score_away, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def game_bettable?
    game.status == 'open'
  end
end
