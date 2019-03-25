class BetsController < ApplicationController
  def create
    @bet = Bet.new(bet_params)
    @bet.user = current_user
    @games = Game.where(matchday: @bet.game.matchday)
    if @bet.save
      render :create_success
    else
      render :create_error
    end
  end

  private

  def bet_params
    params.require(:bet).permit(:game_id, :score_home, :score_away)
  end
end
