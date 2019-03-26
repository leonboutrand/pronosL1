class ScoresUpdater
  def initialize(game)
    @game = game
    puts "\n\n\n\n\n\n\n\n\n\n\n"
    puts "#{@game.team_home} vs #{@game.team_away}"
  end

  def process
    @game.bets.each do |bet|
      increment_points(bet) if !bet.closed && @game.score_home && @game.score_away
    end
  end

  private

  def increment_points(bet)
    puts "\n\n\n\n\n\n\n/*/*/*/*/* UPDATING BET /*/*/*/*/*/*\n\n\n\n\n\n\n\n\n\n"
    if good_result?(bet)
      if (@game.score_home == bet.score_home) && (@game.score_away == bet.score_away)
        bet.update(points: 10) # good score
      elsif (bet.score_home == bet.score_away) || ((@game.score_home - bet.score_home).abs + (@game.score_away - bet.score_away).abs == 1)
        bet.update(points: 7) # equality score or 1 goal to good score
      elsif (@game.score_home - bet.score_home).abs + (@game.score_away - bet.score_away).abs == 2
        bet.update(points: 6) # 2 goals to good score
      else bet.update(points: 5)
      end
    elsif (@game.score_home == bet.score_home) || (@game.score_away == bet.score_away)
      bet.update(points: 1) # good team
    else bet.update(points: 0) # good score
    end
    bet.update(closed: true) if @game.status == "finished"
  end

  def good_result?(bet)
    return true if (@game.score_home > @game.score_away) && (bet.score_home > bet.score_away)

    return true if (@game.score_home == @game.score_away) && (bet.score_home == bet.score_away)

    return true if (@game.score_home < @game.score_away) && (bet.score_home < bet.score_away)

    return false
  end
end
