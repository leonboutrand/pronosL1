require 'open-uri'

class PagesController < ApplicationController
  def home
    @users = User.all
    RankingCalculator.call
    @teams = Team.all.order(points: :desc, difference_goals: :desc)
  end

  def live
    FootballScraper.new.process
    @games = Game.where(matchday: Game.current_matchday)
  end

  def live_update
    @games = Game.where(matchday: params[:matchday].to_i)
    render :live_update
  end

  def pronos
    @games = Game.where(matchday: Game.current_matchday)
  end

  def pronos_update
    @games = Game.where(matchday: params[:matchday].to_i)
    render :pronos_update
  end
end
