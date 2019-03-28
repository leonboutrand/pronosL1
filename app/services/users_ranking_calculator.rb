class UsersRankingCalculator
  def self.call
    User.all.each do |user|
      puts user.pseudo
      # next if user.bets.empty?

      user.update(game_points: user.bets.map { |bet| bet.points || 0 }.reduce(:+) || 0)
    end
  end
end
