class MatchdayRankingCalculator
  def initialize(matchday = Game.current_matchday)
    @matchday = matchday
  end

  def process
    User.all
    bets = Bet.all.to_a.select { |bet| bet.game.matchday == @matchday }
    User.all.map { |user| rank_row(user, bets.select { |bet| bet.user == user }) }.sort_by { |r| r[:points] }.reverse
  end

  private

  def rank_row(user, bets)
    {
      user: user,
      points: bets.map { |bet| bet.points || 0 }.reduce(:+) || 0,
      nb10: count_bets(bets, 10),
      nb7: count_bets(bets, 7),
      nb6: count_bets(bets, 6),
      nb5: count_bets(bets, 5),
      nb1: count_bets(bets, 1),
      nb0: count_bets(bets, 0)
    }
  end

  def count_bets(bets, score)
    bets.select { |bet| bet.points == score }.count
  end
end
