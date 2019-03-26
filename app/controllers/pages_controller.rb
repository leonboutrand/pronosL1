require 'open-uri'

class PagesController < ApplicationController
  def home
    UsersRankingCalculator.call
    TeamsRankingCalculator.call
    @users = User.all.order(game_points: :desc)
    @teams = Team.all.order(points: :desc, difference_goals: :desc)
  end

  def live
    FootballScraper.new.process
    UsersRankingCalculator.call
    @users = User.all.order(game_points: :desc)
    @games = Game.where(matchday: Game.current_matchday)
  end

  def live_update
    matchday = params[:matchday].to_i
    if pending_games?(matchday)
      FootballScraper.new(matchday).process
      UsersRankingCalculator.call
    end
    @users = User.all.order(game_points: :desc)
    @games = Game.where(matchday: matchday)
    render :live_update
  end

  def pronos
    @games = Game.where(matchday: Game.current_matchday)
  end

  def pronos_update
    @games = Game.where(matchday: params[:matchday].to_i)
    render :pronos_update
  end

  private

  def pending_games?(matchday)
    matchday < Game.current_matchday ? Game.where(matchday: matchday).any? { |game| game.status != 'finished' } : false
  end
end
