module RankingCalculator
  def self.call
    t = Time.now
    Team.all.each do |team|
      puts "\n\n*******  #{team.name}\n\n"
      balance = update_goals(team.games_as_team_home, team.games_as_team_away)
      points = update_points_home(team.games_as_team_home) + update_points_away(team.games_as_team_away)
      team.update(
        points: points,
        scored_goals: balance[0],
        conceded_goals: balance[1],
        difference_goals: balance[0] - balance[1]
      )
    end
    puts "#{(Time.now - t)} seconds"
  end

  def self.update_points_home(games)
    points = 0
    games.each do |game|
      next unless game.score_home

      if game.score_home > game.score_away
        points += 3
      elsif game.score_home == game.score_away
        points += 1
      end
    end
    points
  end

  def self.update_points_away(games)
    points = 0
    games.each do |game|
      next unless game.score_home

      if game.score_home < game.score_away
        points += 3
      elsif game.score_home == game.score_away
        points += 1
      end
    end
    points
  end

  def self.update_goals(games_home, games_away)
    balance = [0, 0]
    games_home.each do |game|
      next unless game.score_home

      balance[0] += game.score_home
      balance[1] += game.score_away
    end
    games_away.each do |game|
      next unless game.score_home

      balance[0] += game.score_away
      balance[1] += game.score_home
    end
    balance
  end
end
