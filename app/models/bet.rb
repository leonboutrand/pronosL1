class Bet < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :game_id, uniqueness: { scope: :user_id }
end
