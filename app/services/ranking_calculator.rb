module RankingCalculator
  def self.call
    t = Time.now
    Team.all.each do |team|
      puts "\n\n*******  #{team.name}\n\n"
      balance = update_goals(team.games_as_team_home, team.games_as_team_away)
      points = update_points_home(team.games_as_team_home) + update_points_away(team.games_as_team_away)
      team.update(
        points: points,
        scored_goals: balance[:scored_goals],
        conceded_goals: balance[:conceded_goals],
        difference_goals: balance[:scored_goals] - balance[:conceded_goals],
        played_games: balance[:played_games]
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
    balance = { scored_goals: 0, conceded_goals: 0, played_games: 0 } # [0, 0, 0]
    games_home.each do |game|
      next unless game.score_home

      balance[:scored_goals] += game.score_home
      balance[:conceded_goals] += game.score_away
      balance[:played_games] += 1
    end
    games_away.each do |game|
      next unless game.score_home

      balance[:scored_goals] += game.score_away
      balance[:conceded_goals] += game.score_home
      balance[:played_games] += 1
    end
    balance
  end
end
