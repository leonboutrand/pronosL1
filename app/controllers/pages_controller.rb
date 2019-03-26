require 'open-uri'

class PagesController < ApplicationController
  def home
    @users = User.all
    TeamsRankingCalculator.call
    @teams = Team.all.order(points: :desc, difference_goals: :desc)
  end

  def live
    FootballScraper.new.process
    @games = Game.where(matchday: Game.current_matchday)
  end

  def live_update
    matchday = params[:matchday].to_i
    FootballScraper.new(matchday).process if pending_games?(matchday) # in case there are reported games
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
