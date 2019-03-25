class BetsController < ApplicationController
  def create
    @bet = Bet.new(bet_params)
    @bet.user = current_user
    @bet.save
    @game = @bet.game
    render :create
  end

  private

  def bet_params
    params.require(:bet).permit(:game_id, :score_home, :score_away)
  end
end
